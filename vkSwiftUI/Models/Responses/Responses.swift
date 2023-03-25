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

final class ResponseListItems<T: Decodable>: Decodable {
    let items: [T]

    private enum CodingKeys: String, CodingKey {
        case items
    }
}

final class ResponseSuccess: Decodable {
    let success: Bool

    private enum CodingKeys: String, CodingKey {
        case success
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Int.self, forKey: .success).getBool ? true : false
    }
}
