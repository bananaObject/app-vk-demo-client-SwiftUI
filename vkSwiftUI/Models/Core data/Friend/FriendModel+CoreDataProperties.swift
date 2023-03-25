//
//  FriendModel+CoreDataProperties.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.03.2023.
//
//

import CoreData

extension FriendModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendModel> {
        return NSFetchRequest<FriendModel>(entityName: "FriendModel")
    }

    @NSManaged public var avatar: String
    @NSManaged public var firstName: String
    @NSManaged public var id: Int32
    @NSManaged public var lastName: String
    @NSManaged public var online: Bool
    @NSManaged public var notAvailable: Bool
}

extension FriendModel: Identifiable { }
