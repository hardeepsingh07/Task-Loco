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
    let data: User?
    let error: ResponseError?
}

struct User: Codable {
	let id: String
	let username: String
	let name: String?
	let email: String?
    let password: String?
    let apiKey: String
	let createdAt: Date
	let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, name, email, password, apiKey, createdAt, updatedAt
    }
}
