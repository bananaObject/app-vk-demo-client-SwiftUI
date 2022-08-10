//
//  ApiVKModel.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 27.02.2022.
//

import Foundation

/// Дженерик ответ  сервера.
final class ResponseItem<T: Decodable>: Decodable {
    let response: T

    private enum CodingKeys: String, CodingKey {
        case response
    }
}

/// Дженерик ответ  сервера  api для списка.
final class ResponseList<T: Decodable> {
    let items: [T]

    init(
        _ items: [T],
        _ nextFrom: String? = nil
    ) {
        self.items = items
    }
}
