//
//  EndpointData.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import Alamofire

enum EndpointData{
	case login(username: String, password: String)
	case signUp(name: String, email: String, username: String, password: String)
	case logout(username: String)
	case allUsers
	case createTask(task: Task)
	case updateTask(task: Task)
	case allTasks
	case todayTasks(username: String)
	case taskPending
	case taskInProgress
	case taskCompleted
	case taskHighPriority
	case taskStandPriority
	case taskRemove(taskId: String)
}

private enum PathConstants {
	static var root = "/"
	static var user = "/user"
	static var task = "/task"
	static var login = "\(user)/login"
	static var allUsers = "\(user)/names"
	static var signUp = user
	static var logout = "\(user)/logout"
	static var createTask = task
	static var updateTask = "\(task)/"
	static var allTasks = "\(task)/all"
	static var todayTasks = "\(task)/"
	static var taskPending = "\(task)/status/pending"
	static var taskInProgress = "\(task)/status/inprogress"
	static var taskCompleted = "\(task)/status/completed"
	static var taskHighPriority = "\(task)/priority/high"
	static var taskStandPriority = "\(task)/priority/standard"
	static var removeTask = "\(task)/"
}

private enum UrlConstants {
	static var baseUrl = "http://localhost:8080"
	static var contentType = "Content-Type"
	static var applicationJson = "application/json"
}

private enum ParameterConstants {
	static var name = "name"
	static var email = "email"
	static var username = "username"
	static var password = "password"
	static var title = "title"
	static var description = "description"
	static var completeBy = "completeBy"
	static var assignee = "assignee"
	static var responsible = "responsible"
	static var priority = "priority"
	static var status = "status"
}

extension EndpointData: Endpoint {
	
	var baseUrl: String {
		return UrlConstants.baseUrl
		
	}
	
	var path: String {
		switch self {
		case .login:
			return PathConstants.login
		case .signUp:
			return PathConstants.signUp
		case .logout:
			return PathConstants.logout
		case .allUsers:
			return PathConstants.allUsers
		case .createTask:
			return PathConstants.createTask
		case .updateTask(let task):
			return PathConstants.updateTask + (task.id ?? "")
		case .allTasks:
			return PathConstants.allTasks
		case .todayTasks(let username):
			return PathConstants.todayTasks + username
		case .taskPending:
			return PathConstants.taskPending
		case .taskInProgress:
			return PathConstants.taskInProgress
		case .taskCompleted:
			return PathConstants.taskCompleted
		case .taskHighPriority:
			return PathConstants.taskHighPriority
		case .taskStandPriority:
			return PathConstants.taskStandPriority
		case .taskRemove(let taskId):
			return PathConstants.removeTask + taskId
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		case .login, .signUp, .logout, .createTask, .updateTask:
			return .post
		case .taskRemove:
			return .delete
		default:
			return .get
		}
	}
	
	var headers: HTTPHeaders {
		return [UrlConstants.contentType: UrlConstants.applicationJson]
	}
	
	var encoding: ParameterEncoding {
		return JSONEncoding.default
	}
	
	var parameters: Parameters {
		switch self {
		case .login(let username, let password):
			return [ParameterConstants.username: username,
					ParameterConstants.password: password]
		case .signUp(let name, let email, let username, let password):
			return [ParameterConstants.name: name,
					ParameterConstants.email: email,
					ParameterConstants.username: username,
					ParameterConstants.password: password]
		case .logout(let username):
			return [ParameterConstants.username: username]
		case .createTask(let task):
			return [ParameterConstants.title: task.title,
					ParameterConstants.description: task.description,
					ParameterConstants.completeBy: task.completeBy,
					ParameterConstants.assignee: task.assignee,
					ParameterConstants.responsible: task.responsible,
					ParameterConstants.priority: task.priority,
					ParameterConstants.status: task.status]
		case .updateTask(let task):
			return [ParameterConstants.title: task.title,
					ParameterConstants.description: task.description,
					ParameterConstants.completeBy: task.completeBy,
					ParameterConstants.assignee: task.assignee,
					ParameterConstants.responsible: task.responsible,
					ParameterConstants.priority: task.priority,
					ParameterConstants.status: task.status]
		default:
			return [:]
		}
	}
	
	var url: URL {
		return URL(string: baseUrl + path)!
	}
	
	var urlRequest: URLRequest {
		var urlRequest = URLRequest(url: url)
		urlRequest.headers = headers
		urlRequest.method = httpMethod
		
		switch self.httpMethod {
		case .post:
			return try! encoding.encode(urlRequest, with: parameters)
		default:
			return urlRequest
		}
	}
}


