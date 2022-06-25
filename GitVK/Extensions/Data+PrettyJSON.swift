//
//  Data+PrettyJSON.swift
//  GitVK
//
//  Created by Назар Ткаченко on 25.06.2022.
//

import Foundation
// Data -> бинарные данные -> двоичные данные -> 1001010101010

extension Data {
    
    var prettyJSON: NSString? {///NSString give us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }

    var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }
    
        return prettyPrintedString
    }

}
