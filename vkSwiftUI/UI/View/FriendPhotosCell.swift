//
//  FriendPhotosCell.swift
//  vkSwiftUI
//
//  Created by Ke4a on 15.08.2022.
//

import SwiftUI

struct FriendPhotosCell: View {
    @State private var isLike = false

    var body: some View {
        ZStack(alignment: .bottom) {
            friendPhoto
            GeometryReader { geo in
                likePhoto
                    .offset(x: geo.size.width - 40,
                            y: geo.size.height - 40)
            }
        }
    }
}

extension FriendPhotosCell {
    private var friendPhoto: some View {
        Image("friendFoto")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }

    private var likePhoto: some View {
        Image("like")
            .resizable()
            .frame(maxWidth: 30, maxHeight: 30)
            .foregroundColor(isLike ? .red : .gray)
            .rotation3DEffect(.degrees(isLike ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.5)) {
                    isLike.toggle()
                }
            }
    }
}

struct FriendPhotosCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendPhotosCell()
    }
}
