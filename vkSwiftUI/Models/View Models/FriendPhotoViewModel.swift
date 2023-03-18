//
//  FriendPhotoViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 22.08.2022.
//

import Foundation

struct FriendPhotoViewModel {
    var id: Int
    var url: String
    var ownerId: Int
    var albumId: Int
    var likes: Bool
    var imageData: Data?
}
