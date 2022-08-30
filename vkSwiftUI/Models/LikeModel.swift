//
//  LikeModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 23.08.2022.
//

import Foundation

class LikeModel: Decodable {
    var likes: Int

    private enum CodingKeys: String, CodingKey {
        case likes
    }
}
