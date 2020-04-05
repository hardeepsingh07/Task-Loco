//
//  ProjectInfo.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

struct ProjectResponse: Response {
    let responseCode: Int
    let message: String
    let data: [Project]?
    let error: ResponseError?
}

struct Project: Codable {
	let id: String
	let name: String
	let projectId: String
    let description: String?
	let users: [UserHeader]
	let starred: Bool
	let createdAt: String? = nil
	let updatedAt: String? = nil

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, projectId, description, users, starred, createdAt, updatedAt
    }
}
