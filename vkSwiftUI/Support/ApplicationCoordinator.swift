//
//  ApplicationCoordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.08.2022.
//

import SwiftUI
import UIKit

class ApplicationCoordinator: Coordinator {
    private let viewModel: ChooseViewModel = ChooseViewModel()

    let window: UIWindow

    private var coordinator: [Coordinating] = []

    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let coordinator = ChooseCoordinator(self)
        coordinator.start()
        window.rootViewController = coordinator.controller
        self.newCoordinating(coordinator)
    }

    func newCoordinating(_ coordinator: Coordinating) {
        self.coordinator = [coordinator]
    }
}
