//
//  Coordinator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.08.2022.
//

import UIKit

protocol Coordinator {
    var controller: UIViewController? { get }
    func newCoordinatings(_ coordinating: Coordinating)
    func newCoordinatings(_ coordinatings: [Coordinating])
    func presentController(_ controller: UIViewController)
    func navigationPushController(_ controller: UIViewController)
}
