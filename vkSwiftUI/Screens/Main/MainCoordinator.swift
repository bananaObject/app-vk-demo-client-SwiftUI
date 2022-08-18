//
//  MainCoordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 17.08.2022.
//

import Combine
import SwiftUI
import UIKit

class MainCoordinator: Coordinating {
    var applicationCoordinator: Coordinator
    var controller: UIViewController

    private let coreData = Persistence()
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ controller: UIViewController, _ appCordinator: Coordinator) {
        self.controller = controller
        self.applicationCoordinator = appCordinator
    }

    public func start() {
        let context = coreData.container.viewContext

        let vc = UIHostingController(rootView: MainScreen()
            .environment(\.managedObjectContext, context))
        vc.modalPresentationStyle = .fullScreen
        controller.present(vc, animated: true)
    }
}
