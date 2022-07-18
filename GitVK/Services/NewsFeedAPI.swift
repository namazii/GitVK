//
//  NewsFeedAPI.swift
//  GitVK
//
//  Created by Назар Ткаченко on 11.07.2022.
//

import Foundation

//CellModel - модель подготовленная для отображения на ячейке
struct PostCellModel {
    var authorName: String
    var authorImageUrl: String
    var text: String
    var photoUrl: String
    var likesCount: Int
}

class NewsFeedAPI {
    
    func fetchNewsFeed(offset: Int = 0) async throws -> ([PostCellModel]) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "filters", value: "post, photo, friend, photo_tag, wall_photo, note"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else { return ([]) }
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(data.prettyJSON as Any)
            
            
            let responseObject = try JSONDecoder().decode(NewsFeedJSON.self, from: data)
            
            let newsItem: [Post] = responseObject.response.items
            let profiles: [Profile] = responseObject.response.profiles ?? []
            let groups: [NewsGroup] = responseObject.response.groups ?? []
        
            var cellModels: [PostCellModel] = []
            
            for post in newsItem {
                
                if post.postType != "post" { continue }
                
                let text = post.text ?? ""
                let photoUrl = post.attachments?.first?.photo?.sizes.last?.url ?? ""
                let likesCount = post.likes?.count ?? 0
                
                
                var authorName = ""
                var authorImageUrl = ""
                
                if post.sourceID < 0 {
                    //groups
                    let group = groups.first(where: { $0.id == abs(post.sourceID) })
                    authorName = group?.name ?? ""
                    authorImageUrl = group?.photo100 ?? ""
                } else {
                    //profiles
                    let profile = profiles.first(where: { $0.id == post.sourceID })
                    authorName = "\(profile?.firstName ?? "") \(profile?.lastName ?? "")"
                }
                
                let cellModel = PostCellModel(authorName: authorName,
                                              authorImageUrl: authorImageUrl,
                                              text: text,
                                              photoUrl: photoUrl,
                                              likesCount: likesCount)
                
                cellModels.append(cellModel)
            }
            
            return (cellModels)
        } catch  {
            print(error)
            throw error
        }
    }
}
