//
//  GroupsEndpoint.swift
//  GitVK
//
//  Created by Назар Ткаченко on 08.07.2022.
//

import Foundation

enum GroupsEndpoint: Endpoint {
    
    case fetchGroups(offset: Int)
    //case searchGroups
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default :
            return "api.vk.com"
        }
    }
    
    var path: String {
        switch self {
        case .fetchGroups:
            return "/method/groups.get"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchGroups(let offset):
            return [URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
                    URLQueryItem(name: "extended", value: "1"),
                    URLQueryItem(name: "fields", value: "description, verified, status, members_count"),
                    URLQueryItem(name: "offset", value: "\(offset)"),
                    URLQueryItem(name: "count", value: "20"),
                    URLQueryItem(name: "access_token", value: Session.shared.accessToken),
                    URLQueryItem(name: "v", value: Session.shared.version)]
        }
    }

    
    var method: String {
        switch self {
        case .fetchGroups:
            return "GET"
        }
    }
    
    
}

