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
    // MARK: - Public Properties

    private(set) var controller: UIViewController?

    // MARK: - Private Properties

    private let viewModel = OnboardingViewModel()
    private var cancellables: Set<AnyCancellable> = []

    private var applicationCoordinator: Coordinator

    // MARK: - Initialization

    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
    }

    // MARK: - Public Methods

    func start() {
        let view = OnboardingScreen(viewModel: self.viewModel)
        self.controller = UIHostingController(rootView: view)
        configureRx()
    }

    // MARK: - Private Methods

    private func configureRx() {
        self.viewModel.tokenIsValidPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                guard let self = self else { return }

                if isValid {
                    self.openMainScreen()
                } else {
                    self.openLoginScreen()
                }
            }
            .store(in: &self.cancellables)
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
