//
//  ChooseViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import Foundation

class ChooseViewModel: ObservableObject {
    var loadIsCompleted: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }

    var tokenIsValid: Bool = false {
        didSet {
            loadIsCompleted = true
        }
    }

    init() {}

    func checkToken() {
        // В будущем добавлю запрос на проверку токена
        loadIsCompleted = true

        guard let _ = KeychainLayer.shared.get(.token) else {
            tokenIsValid = false
            return
        }

        tokenIsValid = true
    }
}
