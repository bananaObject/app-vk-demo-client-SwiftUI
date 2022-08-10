//
//  FriendPhotosCollection.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct FriendPhotosCollection: View {
    var friend: FriendViewModel

    var body: some View {
        VStack {}
            .navigationTitle("Photo \(friend.lastName)")
    }
}

struct FriendPhotosCollection_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotosCollection(friend: FriendViewModel(id: 0, firstName: "Bery", lastName: "Jaaamr", image: nil))
    }
}
