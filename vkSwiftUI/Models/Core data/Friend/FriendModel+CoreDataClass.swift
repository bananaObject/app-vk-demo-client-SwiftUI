//
//  FriendModel+CoreDataClass.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.03.2023.
//
//
import CoreData

@objc(FriendModel)
public class FriendModel: NSManagedObject {
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("no context!")
        }

        self.init(context: context)
    }

    func updateModel(_ data: ResponseFriendModel) {
        if self.id != Int32(data.id) {
            self.id = Int32(data.id)
        }

        if self.online != data.online {
            self.online = data.online
        }

        if   self.firstName != data.firstName {
            self.firstName = data.firstName
        }

        if  self.lastName != data.lastName {
            self.lastName = data.lastName
        }

        if  self.avatar != data.avatar {
            self.avatar = data.avatar
        }

        if  self.notAvailable != (data.deactivated != nil) {
            self.notAvailable.toggle()
        }
    }

    static func deleteAllEntityRequest() -> NSBatchDeleteRequest {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendModel")
        return NSBatchDeleteRequest(fetchRequest: fetchRequest)
    }
}
