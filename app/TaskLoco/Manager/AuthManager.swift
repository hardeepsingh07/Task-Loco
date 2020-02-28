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

enum AuthConstants {
	static let apiKeyTag = "user-api-key"
	static let usernameTag = "username-key"
	static let noApiKey = "no-api-key"
	static let noUsername = "no-username"
}

class AuthManager {
	
	let preferences = UserDefaults.standard
	let taskLocoApi: TaskLocoApi = TaskLocoApiManager()
	
	func login(username: String, password: String) -> Observable<UserInfo> {
		return taskLocoApi.login(username: username, password: password)
			.map({ return self.handleUserResponse($0) })
	}
	
	func signUp(name: String, email: String, username: String, password: String) -> Observable<UserInfo> {
		return taskLocoApi.signUp(name: name, email: email, username: username, password: password)
			.map({ return self.handleUserResponse($0) })
	}
	
	func logout(username: String) -> Observable<UserInfo> {
		return taskLocoApi.logout(username: username)
			.map({ return self.handleUserResponse($0) })
	}
	
	func provideApiKey() -> String {
		return preferences.string(forKey: AuthConstants.apiKeyTag) ?? AuthConstants.noApiKey
	}
	
	func provideUsername() -> String {
		return preferences.string(forKey: AuthConstants.usernameTag) ?? AuthConstants.noUsername
	}
	
	private func handleUserResponse(_ userResponse: UserResponse) -> UserInfo {
		self.preferences.set(userResponse.data?.apiKey, forKey: AuthConstants.apiKeyTag)
		self.preferences.set(userResponse.data?.username, forKey: AuthConstants.usernameTag)
		return userResponse.data!
	}
}
