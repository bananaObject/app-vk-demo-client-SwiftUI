//
//  ImageModifier.swift
//  vkSwiftUI
//
//  Created by Ke4a on 18.07.2022.
//
import SwiftUI

private struct AvatarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .overlay(Circle()
                        .stroke(Color.main,
                                lineWidth: 1))
            .shadow(radius: 5)
    }
}

extension Image {
    func avatarStyle(_ size: Double) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size, alignment: .center)
            .modifier(AvatarModifier())
    }
}
