//
//  ChooseScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct OnboardingScreen: View {
    weak var viewModel: OnboardingViewModel?
    @State private var isAnimating = true

    var body: some View {
        loadingView
            .onAppear {
                viewModel?.checkToken()
            }
    }
}

extension OnboardingScreen {
    private var loadingView: some View {
        ActivityIndicator(isAnimating: $isAnimating, style: .large)
            .color(.white)
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.main)
            .edgesIgnoringSafeArea(.all)

    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen(viewModel: nil)
    }
}
