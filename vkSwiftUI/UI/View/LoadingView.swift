//
//  LoadingView.swift
//  vkSwiftUI
//
//  Created by Ke4a on 14.03.2023.
//

import SwiftUI

struct LoadingView: View {
    @State private var startAnimation = false
    private let dotColor = Color.main

    var body: some View {
        HStack {
            dotView
                .scaleEffect(startAnimation ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 0.5)
                    .repeatForever(),
                           value: startAnimation)
            dotView
                .scaleEffect(startAnimation ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.3),
                           value: startAnimation)
            dotView
                .scaleEffect(startAnimation ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.6),
                           value: startAnimation)
        }
        .onAppear {
            startAnimation = true
        }
    }
}

extension LoadingView {
    var dotView: some View {
        Circle()
            .fill(dotColor)
            .frame(width: 20, height: 20)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
