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
    var contex: NSManagedObjectContext? { get set }
    func sendRequest<T: Decodable>(
        endpoint: ApiEndpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError>
}

extension ApiLayer {
    func sendRequest<T: Decodable>(
        endpoint: ApiEndpoint,
        responseModel: T.Type
    )async -> Result<T, RequestError> {
        do {
            let data = try await requestBase(endpoint: endpoint)
            let decodeResult = try await self.decodeResponse(data: data, decodeModel: T.self)
            return .success(decodeResult.response)
        } catch let error as RequestError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }

    private func decodeResponse<T: Decodable>(data: Data, decodeModel: T.Type
    ) async throws -> Response<T> {
        do {
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = self.contex

            let json: [String: Any]? = try JSONSerialization.jsonObject(
                with: data,
                options: .mutableContainers
            ) as? [String: Any]
            let itemTask = Task<Response<T>, Error> {
                let data = try JSONSerialization.data(withJSONObject: json as Any)
                return try decoder.decode(Response<T>.self, from: data)
            }

            return try await itemTask.value
        } catch {
            throw RequestError.decode
        }
    }
}

class Api: ApiLayer {
    var contex: NSManagedObjectContext?
    init(_ context: NSManagedObjectContext? = nil) {
        self.contex = context
    }
}
