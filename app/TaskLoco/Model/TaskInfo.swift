//
//  TaskInfo.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

struct TaskResponse: Response {
    let response: Int
    let message: String
    let data: [Task]?
    let error: ResponseError?
}

enum Priority: String, Codable {
    case high = "High"
    case standard = "Standard"
}

enum Status: String, Codable {
    case completed = "Completed"
    case inProgress = "In Progress"
    case pending = "Pending"
}

struct Task: Codable {
	let id: String?
	let title: String
	let description: String
	let completeBy: String
	let assignee: String
	let responsible: String?
	let priority: Priority
	let status: Status
	let createdAt: String
	let updatedAt: String
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case title, description, completeBy, assignee, responsible, priority, status, createdAt, updatedAt
	}
	
	func dateAsString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DateFormat.monthDateYearDash
		guard let date = dateFormatter.date(from: completeBy) else { return completeBy }
		dateFormatter.dateFormat = DateFormat.monthDateCommaYear
		return dateFormatter.string(from: date)
	}
}
