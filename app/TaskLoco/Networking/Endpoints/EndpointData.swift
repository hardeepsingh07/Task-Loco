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
	case userTask(username: String)
	case filterTask(status: Status?, priority: Priority?, username: String?)
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
	static var userTask = "\(task)/user/"
	static var filterTask = "\(task)/filter/"
	static var removeTask = "\(task)/"
}

enum QueryConstants {
	static var apiKey = "apiKey"
	static var status = "status"
	static var priority = "priority"
	static var username = "username"
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
	static var closed = "closed"
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
		case .userTask(let username):
			return PathConstants.userTask + username
		case .filterTask:
			return PathConstants.filterTask
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
		switch httpMethod {
		case .post, .put:
			return JSONEncoding.default
		default:
			return URLEncoding.default
		}
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
		case .createTask(let task), .updateTask(let task):
			return [ParameterConstants.title: task.title,
					ParameterConstants.description: task.description,
					ParameterConstants.completeBy: task.completeBy,
					ParameterConstants.assignee: [
						ParameterConstants.username: task.assignee.username,
						ParameterConstants.name: task.assignee.name,
					],
					ParameterConstants.responsible: [
						ParameterConstants.username: task.responsible.username,
						ParameterConstants.name: task.responsible.name,
					],
					ParameterConstants.priority: task.priority.rawValue,
					ParameterConstants.status: task.status.rawValue]
		case .filterTask(let status, let priority, let username):
			var dictionary: [String: String] = [:]
			if(status != nil) { dictionary[QueryConstants.status] = status?.rawValue }
			if(priority != nil) { dictionary[QueryConstants.priority] = priority?.rawValue }
			if(username != nil) { dictionary[QueryConstants.username] = username }
			return dictionary
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
			return try! encoding.encode(urlRequest, with: parameters)
		}
	}
}


