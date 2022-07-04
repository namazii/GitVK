//
//  Session.swift
//  GitVK
//
//  Created by Назар Ткаченко on 21.06.2022.
//

import Foundation
import SwiftKeychainWrapper

//Класс-сервис - кот. выполняет бизнес-логику - управлять токеном
class Session {
    private init() {}
    
    //Глобальная память, константа
    static let shared = Session()
    
    var version: String = "5.131"
    
    //Keychain
    var accessToken: String {
        get {
            return KeychainWrapper.standard.string(forKey: "accessToken") ?? ""
        }
        set(newValue) {
            KeychainWrapper.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    //UserDefaults
    var userId: Int {
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
    var expiresIn: String { //Сколько секунд действителен токен
        get {
            return UserDefaults.standard.string(forKey: "expiresIn") ?? ""
        }
        set {
            let tokenDate = Date(timeIntervalSinceNow: Double(newValue) ?? 0)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
            let dateString = dateFormatter.string(from: tokenDate)
            
            UserDefaults.standard.set(dateString, forKey: "expiresIn")
        }
    }
    
    //isTokenValid
    
     static var isTokenValid: Bool {
         let expiresIn = UserDefaults.standard.string(forKey: "expiresIn") ?? ""
         
//        let tokenDate = Date(timeIntervalSinceNow: Double(expiresIn))
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
         guard let tokenDate = dateFormatter.date(from: expiresIn) else { return false }
//         print("TOKEN DATE \(tokenDate)")
        let currentDate = Date()
//         print("CURRENT DATE\(currentDate)")
        
        return currentDate < tokenDate
    }
}
