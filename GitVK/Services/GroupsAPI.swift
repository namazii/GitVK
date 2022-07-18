//
//  GroupsAPI.swift
//  GitVK
//
//  Created by Назар Ткаченко on 28.06.2022.
//

import Foundation

class GroupsAPI {
    
    // description
    // verified
    // status
    // members_count
    
    /*
    func fetchGroups(offset: Int = 0) async throws -> [Group] {
            do {
                let groups = try await NetworkEngine.request(endpoint: GroupsEndpoint.fetchGroups(offset: offset))
                return groups
            } catch {
                throw error
            }
    }
     */
    
    func fetchGroups(offset: Int = 0, completion: @escaping([Group]) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description, verified, status, members_count"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
    
            guard let jsonData = data else { return }
            
//            print(jsonData.prettyJSON as Any)
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let groupResponse = try jsonDecoder.decode(GroupJSON.self, from: jsonData)
                
                let groups = groupResponse.response.items
                
                DispatchQueue.main.async {
                    completion(groups)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
}
