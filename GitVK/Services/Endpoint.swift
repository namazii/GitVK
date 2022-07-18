//
//  Endpoint.swift
//  GitVK
//
//  Created by Назар Ткаченко on 08.07.2022.
//

import Foundation

//Протокол - через который конструируем URL (интерфейс конструктора URL)
protocol Endpoint {
    
    //https
    var scheme: String { get }
    
    //"api.vk.com"
    var baseURL: String { get }
    
    //"/method/friends.get"
    var path: String { get }
    
    // URLQueryItem(name: "order", value: "random")
    var parameters: [URLQueryItem] { get }
    
    //GET
    var method: String { get }
    
}
