//
//  FriendModel+CoreDataClass.swift
//  vkSwiftUI
//
//  Created by Ke4a on 11.08.2022.
//
//

import Foundation
import CoreData

@objc(FriendModel)
public class FriendModel: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
        case avatar = "photo_100"
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("no context!")
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.online = try container.decode(Int32.self, forKey: .online)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.avatar = try container.decode(String.self, forKey: .avatar)
    }
}
