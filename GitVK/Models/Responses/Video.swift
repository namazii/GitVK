//
//  Video.swift
//  GitVK
//
//  Created by Назар Ткаченко on 18.07.2022.
//

import Foundation

// MARK: - VideoJSON
struct VideoJSON: Codable {
    let response: VideoResponse
}

// MARK: - VideoResponse
struct VideoResponse: Codable {
    let count: Int
    let items: [Video]
}

// MARK: - Video
struct Video: Codable {
    let addingDate, canComment, canLike, canRepost: Int
    let canSubscribe, canAddToFaves, canAdd, comments: Int?
    let date: Int
    let itemDescription: String?
    let duration: Int
    let image: [FirstFrame]
    let firstFrame: [FirstFrame]?
    let width, height: Int?
    let id, ownerID: Int
    let ovID: String?
    let title: String
    let isFavorite: Bool
    let player: String?
    let added: Int
    let itemRepeat: Int?
    let type: TypeEnum
    let views: Int
    let likes: LikesVideo
    let reposts: RepostsVideo
    let localViews: Int?
    let platform: Platform?
    let userID: Int?
    let restriction: Restriction?

    enum CodingKeys: String, CodingKey {
        case addingDate = "adding_date"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case itemDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case ovID = "ov_id"
        case title
        case isFavorite = "is_favorite"
        case player, added
        case itemRepeat = "repeat"
        case type, views, likes, reposts
        case localViews = "local_views"
        case platform
        case userID = "user_id"
        case restriction
    }
}

// MARK: - FirstFrame
struct FirstFrame: Codable {
    let url: String
    let width, height: Int
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case url, width, height
        case withPadding = "with_padding"
    }
}

// MARK: - Likes
struct LikesVideo: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

enum Platform: String, Codable {
    case youTube = "YouTube"
}

// MARK: - Reposts
struct RepostsVideo: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Restriction
struct Restriction: Codable {
    let title, text: String
    let blur, canPlay, canPreview: Int
    let cardIcon: [FirstFrame]
    let disclaimerType: Int
    let listIcon: [FirstFrame]

    enum CodingKeys: String, CodingKey {
        case title, text, blur
        case canPlay = "can_play"
        case canPreview = "can_preview"
        case cardIcon = "card_icon"
        case disclaimerType = "disclaimer_type"
        case listIcon = "list_icon"
    }
}

enum TypeEnum: String, Codable {
    case video = "video"
}


