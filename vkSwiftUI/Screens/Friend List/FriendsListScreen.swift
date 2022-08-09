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

    private func deleteFriend(_ index: IndexSet, _ section: [String]) {
        let indexSection = friendsSection.firstIndex(of: section) ?? 0

        if friendsSection[indexSection].count <= 1 {
            friendsSection.remove(at: indexSection)
        } else {
            friendsSection[indexSection].remove(atOffsets: index)
        }
    }

    private func moveFriend(_ index: IndexSet, _ section: [String], _ value: Int) {
        let indexSection = friendsSection.firstIndex(of: section) ?? 0
        friendsSection[indexSection].move(fromOffsets: index, toOffset: value)
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
                    .onDelete { index in
                        deleteFriend(index, section)
                    }
                    .onMove { index, value in
                        moveFriend(index, section, value)
                    }
                }
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
