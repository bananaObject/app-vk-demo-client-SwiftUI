//
//  HTTPClient.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 17.05.2022.
//

import CoreData
import Foundation
import SwiftUI

protocol ApiLayer: RequestBase {
    var contex: NSManagedObjectContext { get set }
    func sendRequestList<T: Decodable>(
        endpoint: ApiEndpoint,
        responseModel: T.Type
    ) async -> Result<ResponseList<T>, RequestError>
}

extension ApiLayer {
    func sendRequestList<T: Decodable>(
        endpoint: ApiEndpoint,
        responseModel: T.Type
    )async -> Result<ResponseList<T>, RequestError> {
        do {
            let data = try await requestBase(endpoint: endpoint)
            let decodeResult = try await self.decodeResponse(data: data, decodeModel: T.self)
            return .success(decodeResult)
        } catch let error as RequestError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }

    private func decodeResponse<T: Decodable>(data: Data,
                                              decodeModel: T.Type
    ) async throws -> ResponseList<T> {
        do {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.contex

            let json: [String: Any]? = try JSONSerialization.jsonObject(
                with: data,
                options: .mutableContainers
            ) as? [String: Any]
            let responseJson: [String: Any]? = json?["response"] as? [String: Any]
            let itemsTask = Task<[T], Error> {
                let data = try JSONSerialization.data(withJSONObject: responseJson?["items"] as Any)
                return try decoder.decode([T].self, from: data)
            }

            let items = try await itemsTask.value
            return ResponseList(items)
        } catch {
            throw RequestError.decode
        }
    }
}

class Api: ApiLayer {
    var contex: NSManagedObjectContext
    init(_ context: NSManagedObjectContext) {
        self.contex = context
    }
}
