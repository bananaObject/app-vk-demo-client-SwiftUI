//
//  ChooseViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import Foundation

class ChooseViewModel: ObservableObject, RequestBase {
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

    private func requestCheckTokenAsync() async throws -> Bool {
        let data = try await requestBase(endpoint: .getUser)

        let json: [String: Any]? = try JSONSerialization.jsonObject(
            with: data,
            options: .mutableContainers
        ) as? [String: Any]

        let result = json?.keys.contains("response") ?? false

        return result
    }

    func checkToken() {
        Task { @MainActor in
            tokenIsValid = try await requestCheckTokenAsync()
        }
    }
}
