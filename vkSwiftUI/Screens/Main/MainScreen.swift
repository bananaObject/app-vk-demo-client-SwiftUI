//
//  MainScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 07.08.2022.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        TabView {
            friendsTab
            newsTab
            groupsTab
        }
        .accentColor(.main)
    }
}

private extension MainScreen {
    private var friendsTab: some View {
        FriendsListScreen()
            .badge(2)
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Friends")
            }
    }

    private var newsTab: some View {
        FriendsListScreen()
            .background(.blue)
            .tabItem {
                Image(systemName: "newspaper.fill")
                Text("News")
            }
    }

    private var groupsTab: some View {
        FriendsListScreen()
            .tabItem {
                Image(systemName: "rectangle.3.group.bubble.left.fill")
                Text("Groups")
            }

    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
