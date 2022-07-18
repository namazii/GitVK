//
//  NewsFeed.swift
//  GitVK
//
//  Created by Назар Ткаченко on 12.07.2022.
//

import Foundation

// MARK: - PhotoResponse
struct NewsFeedJSON: Codable {
    let response: NewsFeedResponse
}

// MARK: - Response
struct NewsFeedResponse: Codable {
    let items: [Post]
    let groups: [NewsGroup]?
    let profiles: [Profile]?
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct NewsGroup: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
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

// MARK: - ResponseItem
struct Post: Codable {
    let sourceID, date: Int
    let canDoubtCategory, canSetCategory, isFavorite: Bool?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [Attachment]?
    let postSource: PostSource?
    let comments: NewsComments?
    let likes: PurpleLikes?
    let reposts: Reposts?
    let views: Views?
    let shortTextRate: Double?
    let postID: Int?
    let type: String
    let photos: NewsPhotos?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type, photos
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: NewsPhoto?
}

// MARK: - Photo
struct NewsPhoto: Codable {
    let albumID, date, id, ownerID: Int
    let accessKey: String
    let postID: Int?
    let sizes: [NewsSize]
    let text: String
    let userID: Int?
    let hasTags: Bool

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
    }
}

// MARK: - Size
struct NewsSize: Codable {
    let height: Int
    let url: String
    let type: String?
    let width: Int
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
}

// MARK: - Comments
struct NewsComments: Codable {
    let canPost, count: Int
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - PurpleLikes
struct PurpleLikes: Codable {
    let canLike, count, userLikes, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - Photos
struct NewsPhotos: Codable {
    let count: Int
    let items: [NewsPhotosItem]
}

// MARK: - PhotosItem
struct NewsPhotosItem: Codable {
    let albumID, date, id, ownerID: Int
    let accessKey: String
    let canComment: Int
    let postID: Int?
    let sizes: [Size]
    let text: String
    let userID: Int?
    let hasTags: Bool
    let likes: FluffyLikes
    let comments: Views
    let reposts: Reposts
    let canRepost: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case canComment = "can_comment"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
        case likes, comments, reposts
        case canRepost = "can_repost"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - FluffyLikes
struct FluffyLikes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Profile
struct Profile: Codable {
    let online: Int
    let canAccessClosed, isClosed: Bool?
    let id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo?
    let sex: Int
    let screenName, firstName: String?

    enum CodingKeys: String, CodingKey {
        case online
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let appID: Int?
    let isMobile: Bool?
    let lastSeen: Int?
    let isOnline, visible: Bool?

    enum CodingKeys: String, CodingKey {
        case appID = "app_id"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case visible
    }
}
