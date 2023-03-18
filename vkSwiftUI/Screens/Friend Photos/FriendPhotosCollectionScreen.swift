//
//  FriendPhotosCollection.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct FriendPhotosCollectionScreen: View {
    @ObservedObject var viewModel: FriendPhotosViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else {
                collectionPhotos
            }
        }
        .onAppear {
            viewModel.fetchPhotos()
        }
    }
}

extension FriendPhotosCollectionScreen {
    private var collectionPhotos: some View {
        let spacing: Double = 4

        return GeometryReader { geo in
            List {
                ForEach(viewModel.viewModels.indices, id: \.self) { section in
                    HStack(spacing: spacing) {
                        ForEach(viewModel.viewModels[section].indices, id: \.self) { index in
                            let model = viewModel.viewModels[section][index]
                            FriendPhotosCell(isLike: model.likes, imageData: model.imageData,
                                             indexPath: (section: section, item: index),
                                             likeSubject: viewModel.likeIndexSubject)
                                .frame(width: calcWidthCell(geo.size.width,
                                                            spacing,
                                                            viewModel.qtItemsInSection),
                                       height: calcWidthCell(geo.size.width,
                                                             spacing,
                                                             viewModel.qtItemsInSection))
                                .onAppear {
                                    viewModel.loadImage(section: section, index: index)
                                }
                        }
                        Spacer(minLength: 0)
                    }
                    .listRowInsets(.init(top: spacing / 2, leading: spacing, bottom: spacing / 2, trailing: -spacing))
                }
            }
            .listStyle(.plain)
        }
    }

    private func calcWidthCell(_ widthScreen: Double, _ spacing: Double, _ qt: Int) -> Double {
        let spacing = spacing * Double(2 + qt - 1)
        return (widthScreen - spacing) / Double(qt)
    }
}

struct FriendPhotosCollection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // FriendPhotosCollectionScreen()
        }
    }
}
