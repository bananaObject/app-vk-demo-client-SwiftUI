//
//  SceneDelegate.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 26.01.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var applicatyionCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.applicatyionCoordinator = ApplicationCoordinator(window)
        self.applicatyionCoordinator?.start()

        window.makeKeyAndVisible()
    }
}
