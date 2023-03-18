//
//  ImageLoader.swift
//  vkSwiftUI
//
//  Created by Ke4a on 17.03.2023.
//

import Foundation

protocol ImageLoaderProtocol {
    func loadPhotoAsync(_ url: URL) async throws -> Data
}

class ImageLoader: ImageLoaderProtocol {
    func loadPhotoAsync(_ url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

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
