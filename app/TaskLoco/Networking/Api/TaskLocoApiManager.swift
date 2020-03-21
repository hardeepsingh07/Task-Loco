//
//  TaskLocoApiManager.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import os
import RxSwift
import Alamofire

enum ResponseCode {
	static var success = 200
	static var error = 250
}

class TaskLocoApiManager: TaskLocoApi {
	
	func login(username: String, password: String) -> Observable<UserResponse> {
		return self.request(urlRequest: EndpointData.login(username: username, password: password).urlRequest)
	}
	
	func signUp(name: String, email: String, username: String, password: String) -> Observable<UserResponse> {
		return self.request(urlRequest: EndpointData.signUp(name: name, email: email, username: username, password: password).urlRequest)
	}
	
	func logout(username: String) -> Observable<UserResponse> {
		return self.request(urlRequest: EndpointData.logout(username: username).urlRequest)
	}
	
	func allUsers() -> Observable<UserHeaderResponse> {
		return self.request(urlRequest: EndpointData.allUsers.urlRequest)
	}
	
	func createTask(task: Task) -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.createTask(task: task).urlRequest)
	}
	
	func updateTask(task: Task) -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.updateTask(task: task).urlRequest)
	}
	
	func getAllTasks() -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.allTasks.urlRequest)
	}
	
	func getTodayTasks(username: String) -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.todayTasks(username: username).urlRequest)
	}
	
	func taskPending() -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.taskPending.urlRequest)
	}
	
	func taskInProgress() -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.taskInProgress.urlRequest)
	}
	
	func taskCompleted() -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.taskCompleted.urlRequest)
	}
	
	func taskHighPriority() -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.taskHighPriority.urlRequest)
	}
	
	func taskStandardPriority() -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.taskStandPriority.urlRequest)
	}
	
	func taskRemove(taskId: String) -> Observable<TaskResponse> {
		return self.request(urlRequest: EndpointData.taskRemove(taskId: taskId).urlRequest)
	}
	
	
	private func request<T: Codable>(urlRequest: URLRequest) -> Observable<T>  {
		return Observable<T>.create { observer in
			let request = AF.request(urlRequest).responseDecodable { (response: DataResponse<T, AFError>) in
				switch response.result {
				case .success(let data):
					observer.onNext(data)
				case .failure(let error):
					print("AFError: \(error)")
					observer.onError(error)
				}
			}
			return Disposables.create { request.cancel() }
		}
	}
}

struct APIError {
	let name: String
	let message: String
}
