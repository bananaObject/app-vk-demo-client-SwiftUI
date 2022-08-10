//
//  FriendsViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 10.08.2022.
//

import CoreData
import Foundation
import SwiftUI

class FriendsViewModel: ObservableObject {
    @Published var section: [String: [FriendViewModel]] = [:]

    @Environment(\.managedObjectContext) private var context: NSManagedObjectContext
    // в будущем подключу core data
    @FetchRequest(entity: FriendModel.entity(), sortDescriptors: []) private var items: FetchedResults<FriendModel>

    var letter: [String] {
        Array(section.keys).sorted()
    }

    private lazy var api = Api(context)

    func fetchFriends() {
        Task {
            let result = await api.sendRequestList(endpoint: .getFriends,
                                                   responseModel: FriendModel.self)
            switch result {
            case .success(let result):
                await MainActor.run {
                    section = convertToViewModels(result.items)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func deleteFriend(_ index: IndexSet, _ letter: String ) {
        section[letter]?.remove(atOffsets: index)
        if let sectionViewModel = section[letter], sectionViewModel.isEmpty {
            section.removeValue(forKey: letter)
        }
    }

    func moveFriend(_ index: IndexSet, _ letter: String, _ value: Int) {
        section[letter]?.move(fromOffsets: index, toOffset: value)
    }

    private func convertToViewModels(_ friends: [FriendModel]) -> [String: [FriendViewModel]] {
        var section: [String: [FriendViewModel]] = [:]

        friends.forEach { friend in
            let letter = String(friend.lastName?.first ?? "Ы")
            let viewModel = FriendViewModel(id: Int(friend.id),
                                            firstName: friend.firstName ?? "Error",
                                            lastName: friend.lastName ?? "Error",
                                            image: nil)

            section[letter] = (section[letter] ?? []) + [viewModel]
        }

        return section
    }
}
