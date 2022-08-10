//
//  VkSwiftUIApp.swift
//  vkSwiftUI
//
//  Created by Ke4a on 11.07.2022.
//

import SwiftUI

@main
struct VkSwiftUIApp: App {
    private var dataController = Persistence()

    var body: some Scene {
        WindowGroup {
            ChooseScreen()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
