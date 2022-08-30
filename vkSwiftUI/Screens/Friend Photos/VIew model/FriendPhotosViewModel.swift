//
//  FriendPhotosViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 22.08.2022.
//

import Foundation

class FriendPhotosViewModel: ObservableObject {
    private var friend: FriendViewModel
    private var api = Api()

    private var isFetchLike = false

    @Published var viewModels: [FriendPhotoViewModel] = []

    init(_ friend: FriendViewModel) {
        self.friend = friend
    }

    func fetchPhotos() {
        Task(priority: .background) {
            let fetch = await api.sendRequest(endpoint: .getPhotos(userId: friend.id), responseModel: ListItems<PhotoModel>.self)
            switch fetch {
            case .success(let response):
                await MainActor.run {
                    viewModels = convertToViewModels(response.items)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func likeAction(_ index: Int) {
        guard !self.isFetchLike else { return }

        self.isFetchLike.toggle()

        let model = viewModels[index]
        Task(priority: .background) { [weak self] in
            let fetch: Result<LikeModel, RequestError>

            if model.likes {
                fetch = await api.sendRequest(endpoint: .deleteLike(type: .photo, ownerId: model.ownerId, itemId: model.id),
                                              responseModel: LikeModel.self)
            } else {
                fetch = await api.sendRequest(endpoint: .addLike(type: .photo, ownerId: model.ownerId, itemId: model.id),
                                              responseModel: LikeModel.self)
            }

            switch fetch {
            case .success:
                await MainActor.run {
                    viewModels[index].likes.toggle()
                }
            case .failure(let error):
                print(error)
            }

            self?.isFetchLike.toggle()
        }
    }

    private func convertToViewModels(_ photos: [PhotoModel]) -> [FriendPhotoViewModel] {
        return photos.map { photo in
            FriendPhotoViewModel(id: photo.id,
                                 url: photo.sizes.first?.url ?? "",
                                 ownerId: photo.ownerId,
                                 albumId: photo.albumId,
                                 likes: photo.likes.userLikes.getBool)
        }
    }
}
