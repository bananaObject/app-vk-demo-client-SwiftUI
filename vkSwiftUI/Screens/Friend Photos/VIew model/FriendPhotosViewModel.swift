//
//  FriendPhotosViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 22.08.2022.
//

import Combine
import Foundation

class FriendPhotosViewModel: ObservableObject {
    var qtItemsInSection: Int = 2

    @Published var viewModels: [[FriendPhotoViewModel]] = []
    var isLoading = true

    let likeIndexSubject = PassthroughSubject<LikeRequest, Never>()
    private let likesSubject = CurrentValueSubject<[Int: LikeRequest], Never>([:])
    private var subscription: Set<AnyCancellable> = []

    private var friendId: Int
    private let networkApi: NetworkApiProtocol
    private let imageLoader: ImageLoaderProtocol

    init(_ friendId: Int, api: NetworkApiProtocol, imageLoader: ImageLoaderProtocol) {
        self.friendId = friendId
        self.networkApi = api
        self.imageLoader = imageLoader
        configureRx()
    }

    private func configureRx() {
        likeIndexSubject
            .sink { [weak self] request in
                guard let self else { return }
                var temp = self.likesSubject.value
                let id = self.viewModels[request.section][request.item].id
                temp[id] = request
                self.likesSubject.send(temp)
            }.store(in: &subscription)

        likesSubject
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map {
                $0.filter { [weak self] _, like in  self?.viewModels[like.section][like.item].likes != like.isLike }
            }
            .sink { [weak self] result in
                result.forEach { _, value in
                    self?.likeAction(value)
                }
            }
            .store(in: &subscription)
    }

    func fetchPhotos() {
        isLoading = true

        Task(priority: .background) {
            let fetch = await networkApi.sendRequest(endpoint: .getPhotos(userId: friendId),
                                                     responseModel: ResponseListItems<PhotoModel>.self)
            switch fetch {
            case .success(let response):
                await MainActor.run {
                    isLoading = false
                    viewModels = convertToViewModels(response.items)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadImage(section: Int, index: Int) {
        guard self.viewModels[section][index].imageData == nil else { return }

        Task.detached { [weak self] in
            guard let urlString = self?.viewModels[section][index].url,
                    let url = URL(string: urlString) else { return }
            let image = try await self?.imageLoader.loadPhotoAsync(url)

            await MainActor.run { [weak self] in
                self?.viewModels[section][index].imageData = image
            }
        }
    }

    private func likeAction(_ like: LikeRequest) {
        let model = viewModels[like.section][like.item]

        Task(priority: .background) {
            let fetch: Result<LikeModel, RequestError>

            if model.likes {
                fetch = await networkApi.sendRequest(endpoint: .deleteLike(type: .photo,
                                                                           ownerId: model.ownerId,
                                                                           itemId: model.id),
                                                     responseModel: LikeModel.self)
            } else {
                fetch = await networkApi.sendRequest(endpoint: .addLike(type: .photo,
                                                                        ownerId: model.ownerId,
                                                                        itemId: model.id),
                                                     responseModel: LikeModel.self)
            }

            switch fetch {
            case .success:
                await MainActor.run {
                    viewModels[like.section][like.item].likes.toggle()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func convertToViewModels(_ photos: [PhotoModel]) -> [[FriendPhotoViewModel]] {
        var array = Array(photos.reversed())
        var sections: [[FriendPhotoViewModel]] = []

        for _ in 0..<photos.endIndex {
            let photo = array.removeFirst()
            let url = photo.sizes.first { $0.type == "x" }?.url
            let model = FriendPhotoViewModel(id: photo.id,
                                             url: url ?? "",
                                             ownerId: photo.ownerId,
                                             albumId: photo.albumId,
                                             likes: photo.likes.userLikes.getBool)
            if !sections.isEmpty, sections[sections.endIndex - 1].count < qtItemsInSection {
                sections[sections.endIndex - 1].append(model)
            } else {
                sections.append([model])
            }
        }

        return sections
    }
}
