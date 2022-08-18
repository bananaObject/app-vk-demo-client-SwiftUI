//
//  ChooseScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import SwiftUI

struct ChooseScreen: View {
    var viewModel: ChooseViewModel
    
    var body: some View {
        loadingView
            .onAppear {
                viewModel.checkToken()
            }
    }
}

extension ChooseScreen {
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
struct ChooseScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChooseScreen(viewModel: ChooseViewModel())
    }
}
