//
//  EndpointBase.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 17.05.2022.
//

import Foundation

protocol EndpointBase {
    var httpSession: URLSession { get }
    var baseURL: URLComponents { get }
    var token: String? { get }

    var path: String { get }
    var method: RequestMethod { get }
    var params: [URLQueryItem]? { get }
}

extension EndpointBase {
    var httpSession: URLSession {
        URLSession(configuration: URLSessionConfiguration.default)
    }

    var baseURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        return components
    }

    /// получение токена из Keychain
    var token: String? {
        KeychainLayer.shared.get(.token)
    }
}
