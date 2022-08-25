//
//  OnboardingCoordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.08.2022.
//
import Combine
import SwiftUI
import UIKit

class OnboardingCoordinating: Coordinating {
    private(set) var controller: UIViewController?

    private let viewModel: OnboardingViewModel = .init()
    private var cancellables: Set<AnyCancellable> = []

    private var applicationCoordinator: Coordinator

    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
    }

    func start() {
        let view = OnboardingScreen(viewModel: self.viewModel)
        self.controller = UIHostingController(rootView: view)

        self.viewModel.$loadIsCompleted.subscribe(on: RunLoop.main).sink { [weak self] loadIsCompleted in
            guard let self = self else { return }

            if loadIsCompleted && self.viewModel.tokenIsValid {
                self.openMainScreen()
            } else if loadIsCompleted {
                self.openLoginScreen()
            }
        }.store(in: &self.cancellables)
    }

    private func openLoginScreen() {
        let coordinating = LoginCoordinating(applicationCoordinator)
        applicationCoordinator.newCoordinatings(coordinating)
        coordinating.start()
    }

    private func openMainScreen() {
        let coordinating = MainCoordinating(applicationCoordinator)
        applicationCoordinator.newCoordinatings(coordinating)
        coordinating.start()
    }
}
