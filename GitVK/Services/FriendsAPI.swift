//
//  FriendsAPI.swift
//  GitVK
//
//  Created by Назар Ткаченко on 25.06.2022.
//

import Foundation

//класс-сервис -> бизнес-логику -> запросы для друзей
class FriendsAPI {
    
    func fetchFriends(offset: Int = 0, completion: @escaping([Friend]) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "fields", value: "bdate, city,online, photo_50"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
    
            guard let jsonData = data else { return }
            
//            print(jsonData.prettyJSON as Any)
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let friendResponse = try jsonDecoder.decode(FriendResponse.self, from: jsonData)
                
                let friends = friendResponse.response.items
                
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
}
