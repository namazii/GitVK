//
//  NetworkEngine.swift
//  GitVK
//
//  Created by Назар Ткаченко on 08.07.2022.
//

import Foundation

/*
//Универсальный запрос через который ходят все сервисы
class NetworkEngine {
    

#warning("Написать универсальтный запрос через Generic-контейнер")
    
    class func request<T: Codable>(endpoint: Endpoint, model: Model) async throws -> [T] {

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
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let responseObject = try JSONDecoder().decode(model.self, from: data)
            let friends = responseObject.response.items

            return friends
            
        } catch  {
            print(error)
            throw error //return для ошибок
        }
    }
}
*/
