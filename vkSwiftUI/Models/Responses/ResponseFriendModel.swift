//
//  ResponseFriendModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 15.03.2023.
//

import Foundation

extension ResponseFriendModel {
    enum Deactivated: String {
        case deleted
        case unknown

        init?(rawValue: String) {
            self = rawValue == "deleted" ? .deleted : .unknown
        }
    }
}

struct ResponseFriendModel: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    var deactivated: Deactivated?
    let online: Bool
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case deactivated
        case avatar = "photo_100"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let deactivated = try? container.decode(String?.self, forKey: .deactivated) {
            self.deactivated = Deactivated(rawValue: deactivated)
            self.firstName = " "
            self.lastName = "DELETED"
        } else {
            self.firstName = try container.decode(String.self, forKey: .firstName)
            self.lastName = try container.decode(String.self, forKey: .lastName)
        }

        self.id = try container.decode(Int.self, forKey: .id)
        self.online = try container.decode(Int.self, forKey: .online).getBool ? true : false
        self.avatar = try container.decode(String.self, forKey: .avatar)
    }
}
