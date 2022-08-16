//
//  FriendModel+CoreDataProperties.swift
//  vkSwiftUI
//
//  Created by Ke4a on 11.08.2022.
//
//

import Foundation
import CoreData


extension FriendModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendModel> {
        return NSFetchRequest<FriendModel>(entityName: "FriendModel")
    }

    @NSManaged public var avatar: String
    @NSManaged public var firstName: String
    @NSManaged public var id: Int32
    @NSManaged public var lastName: String
    @NSManaged public var online: Int32

}

extension FriendModel : Identifiable {

}
