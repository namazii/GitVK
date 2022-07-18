//
//  VideosAPI.swift
//  GitVK
//
//  Created by Назар Ткаченко on 16.07.2022.
//

import Foundation

class VideosAPI {
    
    func fetchVideos(offset: Int = 0) async throws -> [Video] {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/video.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]

        
        guard let url = urlComponents.url else { return ([]) }
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(data.prettyJSON as Any)
            
            
            let responseObject = try JSONDecoder().decode(VideoJSON.self, from: data)
            
            let videoItem: [Video] = responseObject.response.items
        
            return (videoItem)
            } catch  {
            print(error)
            throw error
        }
    }
}
