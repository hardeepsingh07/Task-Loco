//
//  UserInfo.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let response: Int
    let message: String
    let data: UserInfo?
    let error: ResponseError?
}

struct UserInfo: Codable {
	let id: String
	let username: String
	let name: String?
	let email: String?
    let password: String?
    let apiKey: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, name, email, password
        case apiKey
    }
}

struct ResponseError: Codable {
	let name: String
	let message: String
}
