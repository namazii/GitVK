//
//  FriendsAPI.swift
//  GitVK
//
//  Created by Назар Ткаченко on 25.06.2022.
//

import Foundation

//класс-сервис -> бизнес-логику -> запросы для друзей
class FriendsAPI {
    
    func fetchFriends(completion: @escaping([Friend]) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "fields", value: "bdate, city,online, photo_50"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
    
            guard let data = data else { return }
            
            print(data.prettyJSON as Any)
            
            completion([])
        }.resume()
    }
}
