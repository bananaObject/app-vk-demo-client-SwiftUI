//
//  FriendPhotosCell.swift
//  vkSwiftUI
//
//  Created by Ke4a on 15.08.2022.
//

import Combine
import SwiftUI

struct FriendPhotosCell: View {
    @State var isLike: Bool
    var imageData: Data?
    var indexPath: (section: Int, item: Int)
    var likeSubject: PassthroughSubject<LikeRequest, Never>
    @State var test = true
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geo in
                imageView
                    .frame(width: geo.size.width,
                           height: geo.size.height,
                           alignment: .center)
                    .clipped()
                likePhoto
                    .frame(maxWidth: geo.size.width * 0.15,
                           maxHeight: geo.size.height * 0.15)
                    .offset(x: geo.size.width * 0.8,
                            y: geo.size.height * 0.8)
            }
        }
    }
}

extension FriendPhotosCell {
    private var imageView: some View {
        Group {
            if let data = imageData, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ActivityIndicator(isAnimating: $test, style: .medium)
                    .color(.darkGray)
            }
        }
    }
    
    private var likePhoto: some View {
        Image("like")
            .resizable()
            .scaleEffect(isLike ? 1.1 : 1)
            .foregroundColor(isLike ? .red : .gray)
            .rotation3DEffect(.degrees(isLike ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(.easeInOut(duration: 0.33), value: isLike)
            .onTapGesture {
                isLike.toggle()
                likeSubject.send(.init(section: indexPath.section,
                                       item: indexPath.item,
                                       isLike: isLike))
            }
    }
}

// struct FriendPhotosCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendPhotosCell(imageName: "friendFoto2")
//    }
// }
