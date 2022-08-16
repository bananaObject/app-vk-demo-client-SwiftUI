//
//  ChooseScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct ChooseScreen: View {
    @ObservedObject private var viewModel = ChooseViewModel()

    var body: some View {
        Group {
            if viewModel.tokenIsValid && viewModel.loadIsCompleted {
                MainScreen()
            } else if viewModel.loadIsCompleted {
                LoginScreen()
            } else {
                loadingView
            }
        }
        .onAppear { viewModel.checkToken() }
    }
}

extension ChooseScreen {
    private var loadingView: some View {
        VStack {
            Text("В будущем будет анимация загрузки")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.main)
    }
}

struct ChooseScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChooseScreen()
    }
}
