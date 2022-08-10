//
//  Persistence.swift
//  test UI kit
//
//  Created by Ke4a on 10.08.2022.
//

import CoreData

struct Persistence {
    let container = NSPersistentContainer(name: "database")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
