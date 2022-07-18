//
//  FriendsList.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.07.2022.
//

import SwiftUI

struct FriendsListScreen: View {
    var body: some View {
        VStack {
            Text("Friends")
                .font(.title)
            List(0..<20) { _ in
                ListCell(imageUrl: "friendFoto",
                         textCell: "Aлександр Семенов Шпак")
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListScreen()
    }
}
