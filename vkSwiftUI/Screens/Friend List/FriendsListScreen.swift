//
//  FriendsList.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.07.2022.
//

import SwiftUI

struct FriendsListScreen: View {
    @ObservedObject var viewModel = FriendsViewModel()

    var body: some View {
        NavigationView {
            friendsList
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: EditButton())
                .onAppear {
                    viewModel.fetchFriends()
                }
        }
    }
}

extension FriendsListScreen {
    var friendsList: some View {
        List {
            ForEach(viewModel.letter, id: \.self) { section in
                Section(section) {
                    ForEach(viewModel.section[section] ?? [], id: \.id) { friend in
                        NavigationLink {
                            FriendPhotosCollection(friend: friend)
                        } label: {
                            ListCell(friend)
                        }
                    }
                    .onDelete { viewModel.deleteFriend($0, section) }
                    .onMove { viewModel.moveFriend($0, section, $1) }
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
