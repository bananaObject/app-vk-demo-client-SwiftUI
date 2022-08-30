//
//  ApiVKModel.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 27.02.2022.
//

import Foundation

final class Response<T: Decodable>: Decodable {
    let response: T

    private enum CodingKeys: String, CodingKey {
        case response
    }
}

final class ListItems<T: Decodable>: Decodable {
    let items: [T]

    private enum CodingKeys: String, CodingKey {
        case items
    }
}
