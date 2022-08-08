//
//  FriendsListCell.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.07.2022.
//

import SwiftUI

struct ListCell: View {
    private var text: String
    private var image: String

    init(imageUrl: String, textCell: String) {
        self.text = textCell
        self.image = imageUrl
    }

    var body: some View {
        HStack {
            Image(image)
                .avatarStyle(70)
            Text(text)
                .lineLimit(1)
                .padding()
        }
    }
}
