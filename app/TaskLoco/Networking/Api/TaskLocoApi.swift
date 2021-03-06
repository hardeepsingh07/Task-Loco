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

	func allUsers() -> Observable<UserHeaderResponse>
	
	func createTask(task: Task) -> Observable<TaskResponse>
	
	func updateTask(task: Task) -> Observable<TaskResponse>
	
	func getAllTasks() -> Observable<TaskResponse>
	
	func userTask(projectId: String, username: String) -> Observable<TaskResponse>
	
	func filterTask(projectId: String, status: Status?, priority: Priority?, username: String?) -> Observable<TaskResponse>
			
	func taskRemove(taskId: String) -> Observable<TaskResponse>
	
	func userProjects(username: String) -> Observable<ProjectResponse>
	
	func project(projectId: String) -> Observable<ProjectResponse>
	
	func addMember(projectId: String, userHeaders: [UserHeader]) -> Observable<ProjectResponse>
	
	func removeMember(projectId: String, userHeader: UserHeader) -> Observable<ProjectResponse>
	
	func createProject(project: Project) -> Observable<ProjectResponse>
	
	func updateProject(projectId: String, autoClose: Bool) -> Observable<ProjectResponse>
	
	func updateWithProject(username: String) -> Observable<UserProjectResponse>
	
	func deleteProject(projectId: String) -> Observable<ProjectResponse>
}
