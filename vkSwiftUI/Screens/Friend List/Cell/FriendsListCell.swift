//
//  FriendsListCell.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.07.2022.
//

import SwiftUI

struct ListCell: View {
    private var text: String
    private var image: URL?

    @State private var isShakeOn = false

    init(_ friend: FriendViewModel) {
        self.text = friend.lastName + " " + friend.firstName
        self.image = friend.image
    }

    var body: some View {
        HStack {
            AsyncImage(url: image)
                .avatarStyle(70)
                .shakeAnimation(isShakeOn)
                .onTapGesture {
                    withAnimation(.default) {
                        isShakeOn.toggle()
                    }
                }

            Text(text)
                .lineLimit(1)
                .padding()
        }
    }
}
