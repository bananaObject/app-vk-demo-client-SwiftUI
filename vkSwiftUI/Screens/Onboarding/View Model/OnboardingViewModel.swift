//
//  OnboardingViewModel.swift
//  vkSwiftUI
//
//  Created by Ke4a on 08.08.2022.
//

import Combine
import Foundation

class OnboardingViewModel: RequestBase {
    // MARK: - Public Properties

    var tokenIsValidPublisher: AnyPublisher<Bool, Never> {
        tokenIsValidSubject.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let tokenIsValidSubject = PassthroughSubject<Bool, Never>()

    // MARK: - Public Methods

    func checkToken() {
        Task.detached { @MainActor [weak self] in
            guard let self else { return }

            do {
                self.tokenIsValidSubject.send(try await self.requestCheckTokenAsync())
            } catch {
                self.tokenIsValidSubject.send(false)
            }
        }
    }

    // MARK: - Private Methods

    private func requestCheckTokenAsync() async throws -> Bool {
        let data = try await requestBase(endpoint: .getUser)

        let json: [String: Any]? = try JSONSerialization.jsonObject(
            with: data,
            options: .mutableContainers
        ) as? [String: Any]

        let result = json?.keys.contains("response") ?? false
        return result
    }
}
