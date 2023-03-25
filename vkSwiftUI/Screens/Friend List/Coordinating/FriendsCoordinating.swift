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
    // MARK: - Public Properties

    var controller: UIViewController?

    // MARK: - Private Properties

    private var applicationCoordinator: Coordinator
    private var cancellables: Set<AnyCancellable> = []
    
    private let viewModel: FriendsViewModel

    // MARK: - Initialization

    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
        let context = Persistence()
            .container
            .viewContext
        self.viewModel = FriendsViewModel(context, api: NetworkApi(), imageLoader: ImageLoader())
    }

    // MARK: - Public Methods

    func start() {
        let item = UITabBarItem(title: "Friends",
                                image: UIImage(systemName: "person.2"),
                                selectedImage: UIImage(systemName: "person.2.fill"))

        let controller: UIViewController

        if #available(iOS 14, *) {
            controller = UIHostingController(rootView: FriendsListScreen(viewModel))
        } else {
            // Обернул в контроллер так как ios 13 не поддерживает UIHostingController SwiftUI + Tab bar UIController, работает только ios 14 и выше
            controller = UIViewController()
            let child = UIHostingController(rootView: FriendsListScreen(viewModel))
            controller.addChild(child)
            child.view.frame = controller.view.frame
            controller.view.addSubview(child.view)
            child.didMove(toParent: controller)
        }

        self.controller = controller
        self.controller?.title = "Friends"
        self.controller?.tabBarItem = item

        configureRx()
    }

    // MARK: - Private Methods
    
    private func configureRx() {
        viewModel.selectedFriendPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] friend in
                self?.openFriendPhotosScreen(friend)
            }
            .store(in: &cancellables)

        viewModel.logoutPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.openLogin()
            }
            .store(in: &cancellables)
    }

    private func openFriendPhotosScreen(_ friend: FriendViewModel) {
        let coordinating = FriendPhotosCoordinating(applicationCoordinator, friend: friend)
        coordinating.start()
    }

    private func openLogin() {
        let coordinating = LoginCoordinating(applicationCoordinator)
        applicationCoordinator.newCoordinatings(coordinating)
        coordinating.start()
    }
}
