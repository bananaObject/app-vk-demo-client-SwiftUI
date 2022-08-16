//
//  RequestError.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 17.05.2022.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case parseError
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
