//
//  ResponseFriendModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 15.03.2023.
//

import Foundation

struct ResponseFriendModel: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let online: Bool
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case avatar = "photo_100"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.online = try container.decode(Int.self, forKey: .online) == 1 ? true : false
        self.avatar = try container.decode(String.self, forKey: .avatar)
    }
}
