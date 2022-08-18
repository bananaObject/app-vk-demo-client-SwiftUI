//
//  ChooseCoordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.08.2022.
//
import Combine
import SwiftUI
import UIKit

class ChooseCoordinator: Coordinating {
    var controller: UIViewController = UIViewController()

    private let viewModel: ChooseViewModel = .init()
    private var cancellables: Set<AnyCancellable> = []

    private var applicationCoordinator: Coordinator

    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
    }

    public func start() {
        let view = ChooseScreen(viewModel: viewModel)
        self.controller = UIHostingController(rootView: view)

        viewModel.$loadIsCompleted.subscribe(on: RunLoop.main).sink { [weak self] loadIsCompleted in
            guard let self = self else { return }
        
            if loadIsCompleted && self.viewModel.tokenIsValid {
                self.openMainScreen()
            } else if loadIsCompleted {
                self.openLoginScreen()
            }
        }.store(in: &cancellables)
    }

    private func openLoginScreen() {
        let coordinator = LoginCoordinator(controller, applicationCoordinator)
        coordinator.start()
        applicationCoordinator.newCoordinating(coordinator)
    }

    private func openMainScreen() {
        let coordinator = MainCoordinator(controller, applicationCoordinator)
        coordinator.start()
        applicationCoordinator.newCoordinating(coordinator)
    }
}
