//
//  FriendsViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 10.08.2022.
//

import CoreData
import Foundation
import SwiftUI

class FriendsViewModel: NSObject, ObservableObject {
    @Published var section: [String: [FriendViewModel]] = [:]
    var firstTime = true
    private var context: NSManagedObjectContext?
    private var fetchController: NSFetchedResultsController<FriendModel>?

    var letter: [String] {
        Array(section.keys).sorted()
    }

    private lazy var api = Api(context)

    func setupContex(_ context: NSManagedObjectContext) {
        self.context = context
    }

    func setupCoredataController() {
        guard let context = context else {
            return
        }

        let fetchRequest: NSFetchRequest<FriendModel> = FriendModel.fetchRequest()
        fetchRequest.sortDescriptors = []

        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                     managedObjectContext: context,
                                                     sectionNameKeyPath: nil,
                                                     cacheName: nil)
        fetchController?.delegate = self
        try? fetchController?.performFetch()

        guard let array = fetchController?.fetchedObjects as? [FriendModel] else { return }
        section = convertToViewModels(array)
    }

    func fetchFriends() {
        Task {
            let result = await api.sendRequestList(endpoint: .getFriends,
                                                   responseModel: FriendModel.self)
            switch result {
            case .success(_):
                try? context?.save()
            case .failure(let error):
                print(error)
            }
        }
    }

    func deleteFriend() {

    }

    func deleteAllInBd() {
        guard let array = fetchController?.fetchedObjects as? [FriendModel] else { return }
        array.forEach { value in
            context?.delete(value)
        }
        try? context?.save()
    }

    func moveFriend(_ index: IndexSet, _ letter: String, _ value: Int) {

    }

    private func convertToViewModels(_ friends: [FriendModel]) -> [String: [FriendViewModel]] {
        var section: [String: [FriendViewModel]] = [:]

        friends.forEach { friend in
            guard let character = friend.lastName.first else { return }
            let letter = String(character)
            
            let viewModel = FriendViewModel(id: Int(friend.id),
                                            firstName: friend.firstName,
                                            lastName: friend.lastName,
                                            image: nil)
            var oldValue = section[letter] ?? []
            oldValue.append(viewModel)

            section.updateValue(oldValue, forKey: letter)
        }

        return section
    }

    private func convertToViewModel(_ friend: FriendModel) -> FriendViewModel {
        FriendViewModel(id: Int(friend.id),
                        firstName: friend.firstName,
                        lastName: friend.lastName,
                        image: nil)
    }
}

extension FriendsViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let new = fetchController?.fetchedObjects as? [FriendModel] else { return }
        section = convertToViewModels(new)
    }

//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
//                    didChange anObject: Any,
//                    at indexPath: IndexPath?,
//                    for type: NSFetchedResultsChangeType,
//                    newIndexPath: IndexPath?
//    ) {
//        guard let objects = anObject as? FriendModel, let character = objects.lastName.first else { return }
//        let letter = String(character)
//        guard let index = section[letter]?.firstIndex(where: { $0.id == objects.id }) else { return }
//
//        switch type {
//        case .delete:
//            section[letter]?.remove(at: index)
//            if let sec = section[letter], sec.isEmpty {
//                section.removeValue(forKey: letter)
//            }
//        case .update:
//            section[letter]?[index] = convertToViewModels(objects)
//            print(objects.lastName)
//            print(section[letter]?[index].lastName)
//        default:
//            break
//        }
//    }
}
