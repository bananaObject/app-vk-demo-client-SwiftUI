//
//  ApplicationCoordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.08.2022.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    private var coordinatings: [Coordinating]?
    private(set) var controller: UIViewController?

    private let window: UIWindow

    init(_ window: UIWindow) {
        self.window = window
    }

    func start() {
        let coordinating = OnboardingCoordinating(self)
        coordinating.start()
        self.newCoordinatings(coordinating)
        self.controller = coordinating.controller
        window.rootViewController = self.controller
    }

    func newCoordinatings(_ coordinating: Coordinating) {
        self.coordinatings = [coordinating]
    }

    func newCoordinatings(_ coordinatings: [Coordinating]) {
        self.coordinatings = coordinatings
    }

    func presentController(_ controller: UIViewController) {
        self.controller?.present(controller, animated: true)
        self.controller = controller
    }

    func navigationPushController(_ controller: UIViewController) {
        let currentVc: UINavigationController?

        if let tabBarController = self.controller as? UITabBarController {
            currentVc = tabBarController.selectedViewController as? UINavigationController
        } else {
            currentVc = controller as? UINavigationController
        }

        currentVc?.pushViewController(controller, animated: true)
    }
}
