//
//  TaskLocoApi.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import RxSwift

protocol TaskLocoApi {
	
	func login(username: String, password: String) -> Observable<UserResponse>
	
	func signUp(name: String, email: String, username: String, password: String) -> Observable<UserResponse>
	
	func logout(username: String) -> Observable<UserResponse>
	
	func createTask(task: Task) -> Observable<TaskResponse>
	
	func updateTask(task: Task) -> Observable<TaskResponse>
	
	func getAllTasks() -> Observable<TaskResponse>
	
	func taskPending() -> Observable<TaskResponse>
	
	func taskInProgress() -> Observable<TaskResponse>

	func taskCompleted() -> Observable<TaskResponse>

	func taskHighPriority() -> Observable<TaskResponse>
	
	func taskStandardPriority() -> Observable<TaskResponse>
	
	func taskRemove(taskId: String) -> Observable<TaskResponse>
}
