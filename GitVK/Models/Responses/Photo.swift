//
//  Photo.swift
//  GitVK
//
//  Created by Назар Ткаченко on 03.07.2022.
//

import Foundation

// MARK: - PhotoJSON
struct PhotoJSON: Codable {
    let response: PhotoResponse
}

// MARK: - PhotoResponse
struct PhotoResponse: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, date, id, ownerID: Int
    let canComment: Int
    let sizes: [Size]
    let text: String
    let hasTags: Bool
    let likes: Likes
    let comments, reposts, tags: Comments

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case canComment = "can_comment"
        case sizes, text
        case hasTags = "has_tags"
        case likes, comments, reposts, tags
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
