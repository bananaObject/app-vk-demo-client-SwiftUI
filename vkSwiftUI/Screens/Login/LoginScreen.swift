//
//  LoginScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 12.07.2022.
//

import SwiftUI

struct LoginScreen: View {
    @State private var mainIsShow = false

    private let mainColor = Color.main
    private let safeAreaPadding: CGFloat = 8

    var body: some View {
        if mainIsShow {
            MainScreen()
        } else {
            loginView
        }
    }

    private func buttonAction() {
        mainIsShow = true
    }
}

extension LoginScreen {
    private var loginView: some View {
        VStack {
            Spacer()
            logoImage
            loginButton
            Spacer()
        }
        .padding([.trailing, .leading], safeAreaPadding)
        .background(mainColor)
    }

    private var logoImage: some View {
        Image("vkLogo")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .padding([.trailing, .leading], 32)
            .padding(.bottom, 20)
            .foregroundColor(.white)
    }

    private var loginButton: some View {
        Button("Войти", action: buttonAction)
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
            .background(.white)
            .cornerRadius(8)
            .tint(mainColor)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginScreen()
        }
    }
}
