//
//  WebView.swift
//  vkSwiftUI
//
//  Created by Ke4a on 07.08.2022.
//

import SwiftUI
import WebKit

struct LoginWebView: UIViewRepresentable {
    private let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    init(viewModel delegate: WKNavigationDelegate) {
        webView.navigationDelegate = delegate
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8088608"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups, wall"),
            URLQueryItem(name: "response_type", value: "token")
        ]

        guard let url = urlComponents.url else { return }

        webView.load(URLRequest(url: url))
    }
}
