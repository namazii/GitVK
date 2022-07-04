//
//  PhotosAPI.swift
//  GitVK
//
//  Created by Назар Ткаченко on 03.07.2022.
//

import Foundation

class PhotosAPI {
    
    func fetchPhotos(offset: Int = 0, completion: @escaping([Photo]) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "-22468706"),
            URLQueryItem(name: "album_id", value: "245519033"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "extended", value: "likes"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else { return }
//        print(url)
        let request = URLRequest(url: url)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
    
            guard let jsonData = data else { return }
            
//            print(jsonData.prettyJSON as Any)
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let photoResponse = try jsonDecoder.decode(PhotoResponse.self, from: jsonData)
                
                let photos = photoResponse.response.items
                
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
}
