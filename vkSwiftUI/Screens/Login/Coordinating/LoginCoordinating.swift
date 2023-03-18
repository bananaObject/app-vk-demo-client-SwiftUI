//
//  LoginCoordinating.swift
//  vkSwiftUI
//
//  Created by Ke4a on 17.08.2022.
//

import Combine
import SwiftUI
import UIKit

class LoginCoordinating: Coordinating {
    // MARK: - Private Properties

    private var applicationCoordinator: Coordinator
    
    private let viewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
    }

    // MARK: - Public Methods

    func start() {
        let controller = UIHostingController(rootView: LoginScreen(viewModel: viewModel))
        controller.modalPresentationStyle = .fullScreen
        applicationCoordinator.presentController(controller)
        configureRx()
    }

    // MARK: - Private Methods

    private func configureRx() {
        viewModel.mainIsShowPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.openMainScreen()
            }
            .store(in: &cancellables)
    }
    
    private func openMainScreen() {
        let coordinating = MainCoordinating(applicationCoordinator)
        applicationCoordinator.newCoordinatings(coordinating)
        coordinating.start()
    }
}
