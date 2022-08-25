//
//  PhotoModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 22.08.2022.
//

import Foundation

final class SizeModel: Decodable {
    var height: Int
    var url: String
    var type: String
    var width: Int
}

final class Likes: Decodable {
    var count: Int
    var userLikes: Int

    private enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

final class PhotoModel: Decodable {
    var id: Int
    var ownerId: Int
    var text: String
    var date: Date
    var albumId: Int
    var sizes: [SizeModel]
    var hasTags: Bool
    var likes: Likes

    private enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case date
        case id
        case ownerId = "owner_id"
        case sizes
        case text
        case hasTags = "has_tags"
        case likes
    }
}
