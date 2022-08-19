//
//  FriendsCoordinating.swift
//  vkSwiftUI
//
//  Created by Ke4a on 19.08.2022.
//

import Combine
import SwiftUI
import UIKit

class FriendsCoordinating: Coordinating {
    var controller: UIViewController?

    private var applicationCoordinator: Coordinator
    private var cancellables: Set<AnyCancellable> = []

    private let viewModel: FriendsViewModel

    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
        let context = Persistence()
            .container
            .viewContext
        self.viewModel = FriendsViewModel(context)
    }

    func start() {
        let item = UITabBarItem(title: "Friends",
                                image: UIImage(systemName: "person.2"),
                                selectedImage: UIImage(systemName: "person.2.fill"))

        self.controller = UIHostingController(rootView: FriendsListScreen(viewModel))
        self.controller?.title = "Friends"
        self.controller?.tabBarItem = item

        viewModel.$selectedFriend.subscribe(on: RunLoop.main).sink { [weak self] friend in
            guard let friend = friend
            else { return }

            self?.openFriendPhotosScreen(friend)
        }.store(in: &cancellables)
    }

    private func openFriendPhotosScreen(_ friend: FriendViewModel) {
        let coordinating = FriendPhotosCoordinating(applicationCoordinator, friend: friend)
        coordinating.start()
    }
}
