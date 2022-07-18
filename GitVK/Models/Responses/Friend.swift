//
//  Friend.swift
//  GitVK
//
//  Created by Назар Ткаченко on 25.06.2022.
//

import Foundation

//struct Response: Codable {
//    let response: Items?
//}
//
//struct Items<T: Decodable>: Codable {
//    let count: Int?
//    let items: T?
//}


//FriendsResponse<FriendsItems<T>>

// MARK: - Welcome
struct FriendResponse: Codable {
    let response: FriendItems
}

// MARK: - Response
struct FriendItems: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let bdate: String?
    let city: City?
    let online, id: Int
    let canAccessClosed: Bool?
    let lastName: String
    let photo50: String
    let trackCode: String
    let isClosed: Bool?
    let firstName: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case bdate, city, online, id
        case canAccessClosed = "can_access_closed"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
        case deactivated
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}
