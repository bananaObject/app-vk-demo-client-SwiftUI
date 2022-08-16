//
//  RequestBase.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 19.05.2022.
//

import Foundation

protocol RequestBase {
    func requestBase(endpoint: ApiEndpoint) async throws -> Data
}

extension RequestBase {
    func requestBase(endpoint: ApiEndpoint) async throws -> Data {
        var urlComponents: URLComponents = endpoint.baseURL
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params

        guard let url: URL = urlComponents.url else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)

            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }

            switch response.statusCode {
            case 200...299:
                return data
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            throw error
        }
    }
}
