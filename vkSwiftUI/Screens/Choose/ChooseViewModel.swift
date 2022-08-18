//
//  ChooseViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import Foundation

class ChooseViewModel: ObservableObject, RequestBase {
    @Published var loadIsCompleted: Bool = false
    var tokenIsValid: Bool = false {
        didSet {
            loadIsCompleted = true
        }
    }

    private var firstTime = true

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
        if firstTime {
            Task { @MainActor in
                tokenIsValid = try await requestCheckTokenAsync()
            }
            firstTime = false
        }
    }
}
