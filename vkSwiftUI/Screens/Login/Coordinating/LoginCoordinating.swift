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
    private var applicationCoordinator: Coordinator
    
    private let viewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ appCordinator: Coordinator) {
        self.applicationCoordinator = appCordinator
    }
    
    func start() {
        let controller = UIHostingController(rootView: LoginScreen(viewModel: viewModel))
        controller.modalPresentationStyle = .fullScreen
        applicationCoordinator.presentController(controller)
        
        viewModel.$mainIsShow
            .subscribe(on: RunLoop.main)
            .sink { [weak self] mainIsShow in
                if mainIsShow {
                    self?.openMainScreen()
                }
            }
            .store(in: &cancellables)
    }
    
    private func openMainScreen() {
        let coordinating = MainCoordinating(applicationCoordinator)
        applicationCoordinator.newCoordinatings(coordinating)
        coordinating.start()
    }
}
