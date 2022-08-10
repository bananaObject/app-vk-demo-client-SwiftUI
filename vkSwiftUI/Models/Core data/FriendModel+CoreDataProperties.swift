//
//  FriendModel+CoreDataProperties.swift
//  vkSwiftUI
//
//  Created by Ke4a on 10.08.2022.
//
//

import CoreData
import Foundation

extension FriendModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendModel> {
        return NSFetchRequest<FriendModel>(entityName: "FriendModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var online: Int32
    @NSManaged public var avatar: String?
}

extension FriendModel: Identifiable {

}
