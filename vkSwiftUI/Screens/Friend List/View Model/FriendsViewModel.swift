//
//  FriendsViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 10.08.2022.
//

import Combine
import CoreData
import WebKit

class FriendsViewModel: NSObject, ObservableObject {
    // MARK: - Public Properties

    @Published var sections: [String: [FriendViewModel]] = [:]
    var isLoading: Bool = true

    var letter: [String] {
        Array(sections.keys).sorted()
    }

    var selectedFriendPublisher: AnyPublisher<FriendViewModel, Never> {
        selectedFriendSubject.eraseToAnyPublisher()
    }

    var logoutPublisher: AnyPublisher<Void, Never> {
        logoutSubject.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let selectedFriendSubject = PassthroughSubject<FriendViewModel, Never>()
    private let logoutSubject = PassthroughSubject<Void, Never>()
    private var subscriptions: Set<AnyCancellable> = []

    private var api: NetworkApiProtocol?
    private var imageLoader: ImageLoaderProtocol?

    private var context: NSManagedObjectContext?
    private var fetchController: NSFetchedResultsController<FriendModel>?

    // MARK: - Initialization

    init(_ context: NSManagedObjectContext?, api: NetworkApiProtocol?, imageLoader: ImageLoaderProtocol? ) {
        super.init()
        self.context = context
        setupCoreData()
        self.api = api
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func openFriendScreen(_ friend: FriendViewModel) {
        selectedFriendSubject.send(friend)
    }

    func logout() {
        Task { @MainActor in
            await removeAllUserData()
            self.logoutSubject.send()
        }
    }

    func fetchFriends() {
        guard sections.isEmpty else { return }

        Task(priority: .background) {
            guard let api else { return }

            let result = await api.sendRequest(endpoint: .getFriends,
                                               responseModel: ResponseListItems<ResponseFriendModel>.self)
            switch result {
            case .success(let data):
                updateDB(data.items)
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadImage(key: String, index: Int) {
        guard self.sections[key]?[index].imageData == nil else { return }

        Task(priority: .utility) { [weak self] in
            guard let url = self?.sections[key]?[index].image else { return }
            let image = try await self?.imageLoader?.loadPhotoAsync(url)

            await MainActor.run { [weak self] in
                self?.sections[key]?[index].imageData = image
            }
        }
    }

    func deleteFriend(key: String, index: IndexSet) {
        index.forEach { index in
            Task(priority: .utility) {
                guard let id = sections[key]?[index].id,
                      let api else { return }

                let result = await api.sendRequest(endpoint: .deleteFriends(id: id),
                                                   responseModel: Response<ResponseSuccess>.self)
                switch result {
                case .success:
                    if let friendBd = fetchController?.fetchedObjects?.first(where: { $0.id == id }) {
                        context?.delete(friendBd)
                        try context?.save()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    // MARK: - Private Methods

    private func setupCoreData() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<FriendModel> = FriendModel.fetchRequest()
        fetchRequest.sortDescriptors = []
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                     managedObjectContext: context,
                                                     sectionNameKeyPath: nil,
                                                     cacheName: nil)
        fetchController?.delegate = self
        try? fetchController?.performFetch()
    }

    private func convertToViewModels(_ friends: [FriendModel]) -> [String: [FriendViewModel]] {
        var section: [String: [FriendViewModel]] = [:]

        friends.forEach { friend in
            guard let character = friend.lastName.first else { return }
            let letter = String(character)

            let viewModel = FriendViewModel(id: Int(friend.id),
                                            firstName: friend.firstName,
                                            lastName: friend.lastName,
                                            image: URL(string: friend.avatar))
            var oldValue = section[letter] ?? []
            oldValue.append(viewModel)

            section.updateValue(oldValue, forKey: letter)
        }

        section.forEach { (key: String, value: [FriendViewModel]) in
            let sortSection = value.sorted { $0.lastName < $1.lastName }
            section[key] = sortSection
        }

        return section
    }

    private func convertToViewModel(_ friend: FriendModel) -> FriendViewModel {
        FriendViewModel(id: Int(friend.id),
                        firstName: friend.firstName,
                        lastName: friend.lastName,
                        image: URL(string: friend.avatar))
    }

    private func removeAllUserData() async {
        do {
            try self.context?.execute(FriendModel.deleteAllEntityRequest())
        } catch {
           print(error)
        }
        KeychainLayer.shared.delete(.id)
        KeychainLayer.shared.delete(.token)

        let dataStore = WKWebsiteDataStore.default()
        let dataTypes = Set([WKWebsiteDataTypeCookies])
        let date = Date.distantPast
        await dataStore.removeData(ofTypes: dataTypes, modifiedSince: date)
    }

    private func updateDB(_ newData: [ResponseFriendModel]) {
        do {
            let databaseFriend = fetchController?.fetchedObjects
            var data = newData
            databaseFriend?.forEach { dbFriend in
                if let index = data.firstIndex(where: { $0.id == dbFriend.id }) {
                    let friend = data.remove(at: index)
                    dbFriend.updateModel(friend)
                } else {
                    context?.delete(dbFriend)
                }
            }

            guard let context else { return }
            data.forEach { friend in
                let dbFriend = FriendModel(context: context)
                dbFriend.updateModel(friend)
            }

            try context.save()

            guard let objects = fetchController?.fetchedObjects else { return }
            self.isLoading = false
            Task { @MainActor in
                self.sections = convertToViewModels(objects)
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension FriendsViewModel: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?
    ) {
        guard let object = anObject as? FriendModel, let character = object.lastName.first else { return }
        let letter = String(character)

        switch type {
        case .insert:
            let newFriend = convertToViewModel(object)
            if sections.keys.contains(letter) {
                if let array = sections[letter],
                    let index = array.firstIndex(where: { $0.lastName < newFriend.lastName }) {
                    sections[letter]?.insert(newFriend, at: index)
                } else {
                    sections[letter]?.append(newFriend)
                }
            } else {
                sections[letter] = [newFriend]
            }
        case .delete:
            guard let index = sections[letter]?.firstIndex(where: { $0.id == object.id }) else { return }

            sections[letter]?.remove(at: index)
            if let section = sections[letter], section.isEmpty {
                sections.removeValue(forKey: letter)
            }
        case .update:
            guard let index = sections[letter]?.firstIndex(where: { $0.id == object.id }) else { return }

            sections[letter]?[index] = convertToViewModel(object)
        default:
            break
        }
    }
}
