//
//  FriendsList.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.07.2022.
//

import CoreData
import SwiftUI

struct FriendsListScreen: View {
    @ObservedObject var viewModel: FriendsViewModel

    init(_ viewModel: FriendsViewModel ) {
        self.viewModel = viewModel
    }

    var body: some View {
        friendsList
            .navigationBarItems(leading: logoutButton)
            .onAppear {
                viewModel.fetchFriends()
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension FriendsListScreen {
    private var logoutButton: some View {
        Button("Logout") {
            viewModel.logout()
        }
        .foregroundColor(.red)
    }

    private var friendsList: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else {
                List {
                    ForEach(viewModel.letter, id: \.self) { key in
                        if let section =
                            viewModel.sections[key] {
                            Text(key)
                                .font(Font.body.bold())
                                .opacity(0.33)
                            ForEach(Array(section.enumerated()), id: \.offset) { index, friend in
                                ListCell(friend)
                                    .onTapGesture {
                                        viewModel.openFriendScreen(friend)
                                    }
                                    .onAppear {
                                        viewModel.loadImage(key: key, index: index)
                                    }
                            }
                            .onDelete { index in
                                viewModel.deleteFriend(key: key, index: index)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

struct FriendsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListScreen(FriendsViewModel(nil, api: nil, imageLoader: nil))
    }
}
