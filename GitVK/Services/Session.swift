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
    var expiresIn: Int { //Сколько секунд действителен токен
        get {
            return UserDefaults.standard.integer(forKey: "expiresIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "expiresIn")
        }
    }
    
    //isTokenValid
    
     static var isTokenValid: Bool {
         let expiresIn = UserDefaults.standard.integer(forKey: "expiresIn")
         
        let tokenDate = Date(timeIntervalSinceNow: Double(expiresIn))
        let currentDate = Date()
        
        return currentDate < tokenDate
    }
}
