//
//  TaskInfo.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

struct TaskResponse: Codable {
    let response: Int
    let message: String
    let data: [Task]?
    let error: ResponseError?
}

struct Task: Codable {
	let id: String
	let title: String
	let description: String
	let completeBy: Date
	let assignee: String
	let responsible: String?
	let priority: String
	let status: String
	let createdAt: Date
	let updatedAt: Date
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case title, description, completeBy, assignee, responsible, priority, status, createdAt, updatedAt
	}
	
	func dateAsString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DateFormat.monthDateYear
		return dateFormatter.string(from: completeBy)
	}
}
