//
//  FriendsListCell.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.07.2022.
//

import SwiftUI

struct ListCell: View {
    private var text: String
    private var image: UIImage?
    
    @State private var isShakeOn = false
    
    init(_ friend: FriendViewModel) {
        self.text = friend.lastName + " " + friend.firstName
        if let data = friend.imageData {
            self.image = UIImage(data: data)
        }
    }
    
    var body: some View {
        HStack {
            imageView
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

extension ListCell {
    private var imageView: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .avatarStyle(70)
            } else {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        }
    }
}
