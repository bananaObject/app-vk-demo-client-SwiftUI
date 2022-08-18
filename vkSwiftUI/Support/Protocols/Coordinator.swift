//
//  Coordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.08.2022.
//

import Foundation

protocol Coordinator {
    func newCoordinating(_ child: Coordinating)
}

protocol Coordinating {
    func start()
}
