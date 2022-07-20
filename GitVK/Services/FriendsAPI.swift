//
//  FriendsAPI.swift
//  GitVK
//
//  Created by Назар Ткаченко on 25.06.2022.
//

import Foundation

//класс-сервис -> бизнес-логику -> запросы для друзей
class FriendsAPI {
    
    
    func fetchFriends(offset: Int = 0) async throws -> [Friend] {
        do {
            let friends = try await request(endpoint: FriendsEndpoint.fetchFriends(offset: offset))
            return friends
        } catch {
            throw error
        }
    }
    
    
    func request(endpoint: Endpoint) async throws -> [Friend] {

        //1 Конструктор URL
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        
        components.queryItems = endpoint.parameters
        
        //2 Распаковали URL
        guard let url = components.url else { return [] }
        
        //3 HTTP-запрос
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        //5 Запуск запроса
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let responseObject = try JSONDecoder().decode(FriendJSON.self, from: data)
            let friends = responseObject.response.items

            return friends
            
        } catch  {
            print(error)
            throw error //return для ошибок
        }
    }
    
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
                let friendResponse = try jsonDecoder.decode(FriendJSON.self, from: jsonData)
                
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
