//
//  AuthManager.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import os
import RxSwift

private enum AuthConstants {
	static let apiKeyTag = "user-api-key"
	static let usernameTag = "username-key"
	static let closedTag = "closed-key"
	static let nameTag = "name-key"
	static let noApiKey = "no-api-key"
	static let noUsername = "no-username"
	static let noName = "no-name"
}

class UserManger {
	
	private let preferences: UserDefaults
	private let taskLocoApi: TaskLocoApi
	
	init(preferences: UserDefaults, taskLocoApi: TaskLocoApi) {
		self.preferences = preferences
		self.taskLocoApi = taskLocoApi
	}
	
	func login(username: String, password: String) -> Observable<User> {
		return taskLocoApi.login(username: username, password: password)
			.map({ return try self.handleUserResponse($0)})
	}
	
	func signUp(name: String, email: String, username: String, password: String) -> Observable<User> {
		return taskLocoApi.signUp(name: name, email: email, username: username, password: password)
			.map({ return try self.handleUserResponse($0) })
	}
	
	func logout(username: String) -> Observable<User> {
		return taskLocoApi.logout(username: username)
			.map({ return try self.handleUserResponse($0) })
	}
	
	func provideApiKey() -> String {
		return preferences.string(forKey: AuthConstants.apiKeyTag) ?? AuthConstants.noApiKey
	}
	
	func provideUserHeader() -> UserHeader {
		return UserHeader(username: preferences.string(forKey: AuthConstants.usernameTag) ?? AuthConstants.noUsername,
						  name: preferences.string(forKey: AuthConstants.nameTag) ?? AuthConstants.noName)
	}
		
	private func handleUserResponse(_ userResponse: UserResponse) throws -> User {
		self.preferences.set(userResponse.data?.apiKey, forKey: AuthConstants.apiKeyTag)
		self.preferences.set(userResponse.data?.username, forKey: AuthConstants.usernameTag)
		self.preferences.set(userResponse.data?.name, forKey: AuthConstants.nameTag)
		guard let userInfo = userResponse.data else { throw userResponse.error ??  ErrorConstants.defaultError() }
		return userInfo
	}
	
	func updateClosedSetting(enabled: Bool) {
		self.preferences.set(enabled, forKey: AuthConstants.closedTag)
	}
	
	func isClosedEnabled() -> Bool {
		return self.preferences.bool(forKey: AuthConstants.closedTag)
	}
}