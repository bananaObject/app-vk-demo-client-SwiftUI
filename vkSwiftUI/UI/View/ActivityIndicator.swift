//
//  ActivityIndicator.swift
//  vkSwiftUI
//
//  Created by Ke4a on 17.03.2023.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    private let view: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()

    @Binding var isAnimating: Bool

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        view.style = style
        return view
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }

    func color(_ color: UIColor) -> some View {
        view.color = color
        return self
    }
}
