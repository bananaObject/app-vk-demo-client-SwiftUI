//
//  ChooseScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct OnboardingScreen: View {
    weak var viewModel: OnboardingViewModel?
    
    var body: some View {
        loadingView
            .onAppear {
                viewModel?.checkToken()
            }
    }
}

extension OnboardingScreen {
    var loadingView: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.main)
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen(viewModel: OnboardingViewModel())
    }
}
