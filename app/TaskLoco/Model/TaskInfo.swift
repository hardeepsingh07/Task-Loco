//
//  TaskInfo.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import UIKit

struct TaskResponse: Response {
    let responseCode: Int
    let message: String
    let data: [Task]?
    let error: ResponseError?
}

enum Priority: String, Codable {
    case high = "High"
    case standard = "Standard"
	
	var color: UIColor {
		switch self {
		case .high:
			return UIColor.red
		default:
			return UIColor.black
		}
	}
}

enum Status: String, Codable {
	case completed = "Completed"
	case inProgress = "In Progress"
	case pending = "Pending"
	
	var color: UIColor {
		switch self {
		case .pending:
			return UIColor.systemBlue
		case .inProgress:
			return UIColor.yellow
		case .completed:
			return UIColor.green
		}
	}
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
	
	var completeByAsDate: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DateFormat.monthDateYearDash
		return dateFormatter.date(from: completeBy) ?? Date()
	}
	
	var dayOfWeek: String {
		let customDateFormatter = DateFormatter()
		let calendar = Calendar.current
		return customDateFormatter.shortWeekdaySymbols[calendar.component(.weekday, from: completeByAsDate)]
	}
	
	var dayOfMonth: String {
		return String(Calendar.current.component(.day, from: completeByAsDate))
	}
	
	var monthOfYear: String {
		let customDateFormatter = DateFormatter()
		let calendar = Calendar.current
		return customDateFormatter.shortMonthSymbols[calendar.component(.month, from: completeByAsDate)]
	}
}
