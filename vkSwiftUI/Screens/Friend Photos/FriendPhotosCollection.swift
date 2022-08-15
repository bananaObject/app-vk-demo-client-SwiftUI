//
//  FriendPhotosCollection.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct FriendPhotosCollection: View {
    var friend: FriendViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        collectionPhotos
            .padding([.leading, .trailing], 10)
            .padding([.top], 5)
    }
}

extension FriendPhotosCollection {
    private var collectionPhotos: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0...10, id: \.self) { _ in
                    FriendPhotosCell()
                }
            }
            .navigationTitle("Photo \(friend.lastName) \(friend.firstName)")
        }
    }
}

struct FriendPhotosCollection_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotosCollection(friend: FriendViewModel(id: 0, firstName: "Bery", lastName: "Jaaamr", image: nil))
    }
}
