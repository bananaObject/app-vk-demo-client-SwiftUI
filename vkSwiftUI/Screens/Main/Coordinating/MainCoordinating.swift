//
//  MainCoordinating.swift
//  vkSwiftUI
//
//  Created by Ke4a on 17.08.2022.
//

import SwiftUI
import UIKit

class MainCoordinating: Coordinating {
    // MARK: - Private Properties

    private var applicationCoordinator: Coordinator
    private var childCoordinating: [Coordinating] = []

    // MARK: - Initialization

    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
    }

    // MARK: - Public Methods

    func start() {
        let controller = UITabBarController()
        controller.tabBar.tintColor = .main
        controller.tabBar.backgroundColor = .white
        controller.modalPresentationStyle = .fullScreen
        controller.setViewControllers([
            createFriendController(),
            createStubController("News", "newspaper"),
            createStubController("Groups", "person.3")], animated: false)

        applicationCoordinator.presentController(controller)
        applicationCoordinator.newCoordinatings(childCoordinating)
    }

    // MARK: - Private Methods

    private func createStubController(_ name: String, _ imageName: String) -> UINavigationController {
        let item = UITabBarItem(title: name,
                                image: UIImage(systemName: imageName),
                                selectedImage: UIImage(systemName: "\(imageName).fill"))
        let controller = UIHostingController(rootView: StubView())
        controller.title = name
        controller.tabBarItem = item

        return UINavigationController(rootViewController: controller)
    }

    private func createFriendController() -> UINavigationController {
        let coordinating = FriendsCoordinating(applicationCoordinator)
        childCoordinating.append(coordinating)
        coordinating.start()

        guard let controller = coordinating.controller else { return UINavigationController() }
        return UINavigationController(rootViewController: controller)
    }
}
