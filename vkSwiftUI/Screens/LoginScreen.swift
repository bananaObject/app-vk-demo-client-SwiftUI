//
//  LoginScreen.swift
//  vkSwiftUI
//
//  Created by Ke4a on 12.07.2022.
//

import SwiftUI

struct LoginScreen: View {
    @State var loginText = ""
    @State var passwordText = ""

    let mainColor = Color.main
    let height: Double = 50
    let safeAreaPadding: CGFloat = 8

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                Image("vkLogo")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .padding([.trailing, .leading], 32)
                    .padding(.bottom, 20)
                    .foregroundColor(.white)

                Group {
                    TextField("Ваш логин", text: $loginText)
                    SecureField("Ваш пароль", text: $passwordText)
                }
                .padding(.leading, 8)
                .frame(height: height, alignment: .center)
                .background(.white)
                .cornerRadius(8)
                .clipped()
                .disableAutocorrection(true)

                Button("Войти", action: buttonAction)
                    .frame(width:
                            geometry.size.width - safeAreaPadding * 2,
                           height: height,
                           alignment: .center)
                    .background(.white)
                    .cornerRadius(8)
                    .clipped()
                    .disabled(loginText.isEmpty || passwordText.isEmpty)

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

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginScreen()
        }
    }
}
