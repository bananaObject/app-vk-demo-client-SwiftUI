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
        VStack {
            if viewModel.tokenIsValid && viewModel.loadIsCompleted {
                MainScreen()
            } else if viewModel.loadIsCompleted {
                LoginScreen()
            }
        }
        .onAppear { viewModel.checkToken() }
    }
}

struct ChooseScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChooseScreen()
    }
}
