//
//  FriendsEndpoint.swift
//  GitVK
//
//  Created by Назар Ткаченко on 08.07.2022.
//

import Foundation

//Запрос оформили через enum - конструируемый запрос

enum FriendsEndpoint: Endpoint {
    
    case fetchFriends(offset: Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "api.vk.com"
        }
    }
    
    var path: String {
        switch self {
        case .fetchFriends:
            return "/method/friends.get"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchFriends(let offset):
            return [URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
                    URLQueryItem(name: "order", value: "random"),
                    URLQueryItem(name: "count", value: "20"),
                    URLQueryItem(name: "offset", value: "\(offset)"),
                    URLQueryItem(name: "fields", value: "bdate, city,online, photo_50"),
                    URLQueryItem(name: "access_token", value: Session.shared.accessToken),
                    URLQueryItem(name: "v", value: Session.shared.version)]
        }
    }
    
    var method: String {
        switch self {
        case .fetchFriends:
            return "GET"
        }
    }
}
