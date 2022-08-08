//
//  LoginViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 07.08.2022.
//

import SwiftUI
import WebKit

protocol LoginViewModelInput {
    var webViewIsShow: Bool { get }
}

class LoginViewModel: NSObject, ObservableObject, WKNavigationDelegate, LoginViewModelInput {
    @Published var webViewIsShow: Bool = false 
    @Published var mainIsShow: Bool = false

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url: URL = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }

        decisionHandler(.cancel)

        saveToken(fragment)

        webViewIsShow = false
        mainIsShow = true
    }

    func buttonAction() {
       webViewIsShow = true
    }

    private func saveToken(_ fragment: String) {
        // Received parameters from WebView response
        let params: [String: String] = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        // Write token and id
        if let token: String = params["access_token"], let id: String = params["user_id"] {
            KeychainLayer.shared.set(token, key: .token)
            KeychainLayer.shared.set(id, key: .id)
        }
    }
}
