//
//  FriendPhotosCell.swift
//  vkSwiftUI
//
//  Created by Ke4a on 15.08.2022.
//

import SwiftUI

struct FriendPhotosCell: View {
    var photo: FriendPhotoViewModel
    var index: Int
    var likeAction: (Int) -> Void
   
    var body: some View {
        ZStack(alignment: .bottom) {
            friendPhoto
            GeometryReader { geo in
                likePhoto
                    .offset(x: geo.size.width - 30,
                            y: geo.size.height - 30)
            }
        }
    }
}

extension FriendPhotosCell {
    private var friendPhoto: some View {
        AsyncImage(url: URL(string: photo.url)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, minHeight: 0, alignment: .center)
                .aspectRatio(1, contentMode: .fit)
                .contentShape(Rectangle())
                .clipped()

        } placeholder: {
            Image(systemName: "photo")
                .imageScale(.large)
                .frame(width: 100, height: 100)
        }
    }
    
    private var likePhoto: some View {
        Image("like")
            .resizable()
            .frame(maxWidth: 25, maxHeight: 25)
            .scaleEffect(photo.likes ? 1.33 : 1)
            .foregroundColor(photo.likes ? .red : .gray)
            .rotation3DEffect(.degrees(photo.likes ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(.easeInOut(duration: 0.33), value: photo.likes)
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.5)) {
                    likeAction(index)
                }
            }
    }
}

// struct FriendPhotosCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendPhotosCell(imageName: "friendFoto2")
//    }
// }
