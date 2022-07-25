//
//  NetworkEngine.swift
//  GitVK
//
//  Created by Назар Ткаченко on 08.07.2022.
//

import Foundation

enum AppError: Error {
    case urlNotCreated
    
    var description: String {
        switch self {
            
        case .urlNotCreated:
            return "Ошибка: URL не создана"
        }
    }
}

//Универсальный запрос через который ходят все сервисы
class API {

    class func request<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {

        //1 Конструктор URL
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        
        components.queryItems = endpoint.parameters
        
        //2 Распаковали URL
        guard let url = components.url else {
            throw AppError.urlNotCreated
        }
        
        //3 HTTP-запрос
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        //5 Запуск запроса
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let responseBase = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            let responseObject = responseBase.response

            return responseObject
            
        } catch  {
            print(error)
            throw error //return для ошибок
        }
    }
}

