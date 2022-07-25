//
//  File.swift
//  GitVK
//
//  Created by Artur Igberdin on 23.07.2022.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let response: T
}
