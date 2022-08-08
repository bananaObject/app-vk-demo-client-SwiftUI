//
//  FriendsList.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.07.2022.
//

import SwiftUI

struct FriendsListScreen: View {
    @State private var friendsSection = [
        ["Шпак Aлександр Юрьев ", "Шпек Семенов Aлександр"],
        ["Щпак Василий Семенов"]
    ]

    var body: some View {
        NavigationView {
            friendsList
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: EditButton())
        }
    }
}

extension FriendsListScreen {
    var friendsList: some View {
        List {
            ForEach(friendsSection, id: \.self) { section in
                Section(String(section[0].first!)) {
                    ForEach(section, id: \.self) { friend in
                        NavigationLink {
                            FriendPhotosCollection(nameFriend: friend)
                        } label: {
                            ListCell(imageUrl: "friendFoto",
                                     textCell: friend)
                        }
                    }
                }
            }
            .onDelete { index in
                friendsSection.remove(atOffsets: index)
            }
            .onMove { index, value in
                friendsSection.move(fromOffsets: index, toOffset: value)

            }
            .navigationTitle("Friends")
        }
        .listStyle(.inset)
    }
}

struct FriendsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListScreen()
    }
}
