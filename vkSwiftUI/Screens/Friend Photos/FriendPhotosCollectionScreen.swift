//
//  FriendPhotosCollection.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct FriendPhotosCollectionScreen: View {
    @ObservedObject var viewModel: FriendPhotosViewModel

    let columns: [GridItem] = [
        .init(.adaptive(minimum: 100, maximum: .infinity), spacing: 4, alignment: .center)
    ]

    var body: some View {
        collectionPhotos
            .padding([.leading, .trailing], 10)
            .padding([.top], 4)
            .onAppear {
                viewModel.fetchPhotos()
            }
    }
}

extension FriendPhotosCollectionScreen {
    private var collectionPhotos: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach( 0..<viewModel.viewModels.count, id: \.self) { index in
                    let model = viewModel.viewModels[index]

                    FriendPhotosCell(photo: model, index: index, likeAction: viewModel.likeAction)
                }
            }
        }
    }
}

struct FriendPhotosCollection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // FriendPhotosCollectionScreen()
        }
    }
}
