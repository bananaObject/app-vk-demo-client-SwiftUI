//
//  ViewModifier.swift
//  vkSwiftUI
//
//  Created by Ke4a on 15.08.2022.
//

import SwiftUI

private struct ShakeAnimation: GeometryEffect {
    private var amount: CGFloat = 5
    private var shakesPerUnit: CGFloat = 3
    var animatableData: CGFloat

    init(_ count: Bool) {
        self.animatableData = count ? 1 : 0
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(translationX: 0, y: amount * sin(animatableData * .pi * shakesPerUnit))
        )
    }
}

extension View {
    func shakeAnimation(_ shake: Bool) -> some View {
        self
            .modifier(ShakeAnimation(shake))
    }
}
