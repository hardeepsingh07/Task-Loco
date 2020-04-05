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
		return self.request(endpointData: EndpointData.login(username: username, password: password))
	}
	
	func signUp(name: String, email: String, username: String, password: String) -> Observable<UserResponse> {
		return self.request(endpointData: EndpointData.signUp(name: name, email: email, username: username, password: password))
	}
	
	func logout(username: String) -> Observable<UserResponse> {
		return self.request(endpointData: EndpointData.logout(username: username))
	}
	
	func allUsers() -> Observable<UserHeaderResponse> {
		return self.request(endpointData: EndpointData.allUsers)
	}
	
	func createTask(task: Task) -> Observable<TaskResponse> {
		return self.request(endpointData: EndpointData.createTask(task: task))
	}
	
	func updateTask(task: Task) -> Observable<TaskResponse> {
		return self.request(endpointData: EndpointData.updateTask(task: task))
	}
	
	func getAllTasks() -> Observable<TaskResponse> {
		return self.request(endpointData: EndpointData.allTasks)
	}
	
	func userTask(username: String) -> Observable<TaskResponse> {
		return self.request(endpointData: EndpointData.userTask(username: username))
	}
	
	func filterTask(status: Status?, priority: Priority?, username: String?) -> Observable<TaskResponse> {
		return self.request(endpointData: EndpointData.filterTask(status: status, priority: priority, username: username))
	}
	
	func taskRemove(taskId: String) -> Observable<TaskResponse> {
		return self.request(endpointData: EndpointData.taskRemove(taskId: taskId))
	}
	
	func userProjects(username: String) -> Observable<ProjectResponse> {
		return self.request(endpointData: EndpointData.userProject(username: username))
	}
	
	func project(projectId: String) -> Observable<ProjectResponse> {
		return self.request(endpointData: EndpointData.project(projectId: projectId))
	}
	
	func addMember(projectId: String, userHeader: UserHeader) -> Observable<ProjectResponse> {
		return self.request(endpointData: EndpointData.addMember(projectId: projectId, userHeader: userHeader))
	}
	
	func removeMember(projectId: String, userHeader: UserHeader) -> Observable<ProjectResponse> {
		return self.request(endpointData: EndpointData.removeMember(projectId: projectId, userHeader: userHeader))
	}
	
	func updateProject(projectId: String, autoClose: Bool) -> Observable<ProjectResponse> {
		return self.request(endpointData: EndpointData.updateProject(projectId: projectId, autoClose: autoClose))
	}
	
	private func request<T: Codable>(endpointData: EndpointData) -> Observable<T>  {
		return Observable<T>.create { observer in
			let request = TL.session.request(endpointData.urlRequest).responseDecodable { (response: DataResponse<T, AFError>) in
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
