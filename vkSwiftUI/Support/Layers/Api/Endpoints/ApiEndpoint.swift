//
//  ApiEndpoint.swift
//  vk-withoutStoryboard
//
//  Created by Ke4a on 17.05.2022.
//

import Foundation

/// Точка старта новостей.
enum StartNewsRequest {
    case time(String)
    case from(String)
    case none
}

enum ApiEndpoint {
    case getFriends
    case getPhotos(userId: Int)
    case getGroups
    case getSearchGroup(searchText: String)
    case getCatalogGroups
    case getNews(StartNewsRequest)
    case getUser
}

extension ApiEndpoint: EndpointBase {
    var params: [URLQueryItem]? {
        guard let token = self.token else { return nil }

        var base: [URLQueryItem] = [
            .init(name: "v", value: "5.131"),
            .init(name: "access_token", value: token)
        ]

        switch self {
        case .getFriends:
            base.append(.init(name: "fields", value: "online,photo_100"))
        case .getSearchGroup(let searchText):
            base.append(.init(name: "q", value: searchText))
        case .getGroups:
            base.append(.init(name: "extended", value: "1"))
        case .getNews(let time):
            switch time {
            case .time(let startTime):
                base.append(.init(name: "start_time", value: startTime))
            case .from(let startFrom):
                base.append(.init(name: "start_from", value: startFrom))
            case .none:
                base.append(.init(name: "start_from", value: ""))
            }
            base.append(.init(name: "count", value: "20"))
            base.append(.init(name: "filters", value: "post"))
        case .getPhotos(let id):
            base.append(.init(name: "owner_id", value: String(id)))
            base.append(.init(name: "album_id", value: "profile"))
            base.append(.init(name: "extended", value: "1"))
        case .getCatalogGroups, .getUser:
            break
        }

        return base
    }

    var path: String {
        switch self {
        case .getFriends:
            return "/method/friends.get"
        case .getPhotos:
            return "/method/photos.get"
        case .getGroups:
            return "/method/groups.get"
        case .getSearchGroup:
            return "/method/groups.search"
        case .getCatalogGroups:
            return "/method/groups.getCatalog"
        case .getNews:
            return "/method/newsfeed.get"
        case .getUser:
            return "/method/users.get"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getNews:
            return .POST
        default:
            return .GET
        }
    }
}
