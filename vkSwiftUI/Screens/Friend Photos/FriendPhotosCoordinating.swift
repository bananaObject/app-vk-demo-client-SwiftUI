//
//  FriendPhotosCoordinating.swift
//  vkSwiftUI
//
//  Created by Ke4a on 19.08.2022.
//

import SwiftUI

class FriendPhotosCoordinating: Coordinating {
    private var applicationCoordinator: Coordinator
    private var friend: FriendViewModel

    init(_ appCordinator: Coordinator, friend: FriendViewModel) {
        self.applicationCoordinator = appCordinator
        self.friend = friend
    }

    func start() {
        let controller = UIHostingController(rootView: FriendPhotosCollectionScreen(friend: friend))
        controller.modalPresentationStyle = .fullScreen
        controller.title = "Photos \(friend.firstName) \(friend.lastName)"
        applicationCoordinator.navigationPushController(controller)
    }
}
