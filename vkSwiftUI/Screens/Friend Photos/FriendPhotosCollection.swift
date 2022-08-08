//
//  FriendPhotosCollection.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct FriendPhotosCollection: View {
    var nameFriend: String

    var body: some View {
        VStack {}
        .navigationTitle("Photo \(nameFriend)")
    }
}

struct FriendPhotosCollection_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotosCollection(nameFriend: "Igor")
    }
}
