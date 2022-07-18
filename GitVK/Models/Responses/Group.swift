//
//  Group.swift
//  GitVK
//
//  Created by Назар Ткаченко on 27.06.2022.
//

import Foundation

// MARK: - GroupResponse
struct GroupResponse: Codable {
    let response: GroupItems
}

// MARK: - GroupItems
struct GroupItems: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Group
struct Group: Codable {
    let id, verified: Int
    let itemDescription: String
    let membersCount: Int
    let status, name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, verified
        case itemDescription = "description"
        case membersCount = "members_count"
        case status, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
