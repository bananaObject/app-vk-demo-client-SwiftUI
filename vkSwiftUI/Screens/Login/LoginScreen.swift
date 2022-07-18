//
//  LoginScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 12.07.2022.
//

import SwiftUI

struct LoginScreen: View {
    @State private var loginText = ""
    @State private var passwordText = ""

    private let mainColor = Color.main
    private let height: Double = 50
    private let safeAreaPadding: CGFloat = 8

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                logoImage
                loginPassTextfields
                loginButton(geometry.size.width)

                Spacer()
            }
            .padding([.trailing, .leading], safeAreaPadding)
            .background(mainColor)
        }
    }

    private func buttonAction() {
        print(
            "login: \(loginText)\n" +
            "pass: \(passwordText)"
        )
    }
}

extension LoginScreen {
    private var logoImage: some View {
        Image("vkLogo")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .padding([.trailing, .leading], 32)
            .padding(.bottom, 20)
            .foregroundColor(.white)
    }

    private var loginPassTextfields: some View {
        Group {
            TextField("Ваш логин", text: $loginText)
            SecureField("Ваш пароль", text: $passwordText)
        }
        .padding(.leading, 8)
        .frame(height: height, alignment: .center)
        .background(.white)
        .cornerRadius(8)
        .disableAutocorrection(true)
    }

    private func loginButton(_ screenWidth: CGFloat) -> some View {
        Button("Войти", action: buttonAction)
            .frame(width:
                    screenWidth - safeAreaPadding * 2,
                   height: height,
                   alignment: .center)
            .background(.white)
            .cornerRadius(8)
            .tint(mainColor)
            .disabled(loginText.isEmpty || passwordText.isEmpty)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginScreen()
        }
    }
}
