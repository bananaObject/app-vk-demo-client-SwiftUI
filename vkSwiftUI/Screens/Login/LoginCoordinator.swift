//
//  LoginCoordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 17.08.2022.
//

import Combine
import SwiftUI
import UIKit

class LoginCoordinator: Coordinating {
    private var applicationCoordinator: Coordinator
    private var controller: UIViewController
   
    private let viewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []

    init(_ controller: UIViewController, _ appCordinator: Coordinator) {
        self.controller = controller
        self.applicationCoordinator = appCordinator
    }

    public func start() {
        let vc = UIHostingController(rootView: LoginScreen(viewModel: viewModel))
        vc.modalPresentationStyle = .fullScreen
        controller.present(vc, animated: true)

        controller = vc

        viewModel.$mainIsShow.subscribe(on: RunLoop.main).sink { [weak self] mainIsShow in
            guard let self = self else { return }

            if mainIsShow {
                self.openMainScreen()
            }
        }.store(in: &cancellables)
    }

    private func openMainScreen() {
        let coordinator = MainCoordinator(controller, applicationCoordinator)
        coordinator.start()
        applicationCoordinator.newCoordinating(coordinator)
    }
}
