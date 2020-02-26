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
	static let noApiKey = "no-api-key"
}

class AuthManager {
	
	let preferences = UserDefaults.standard
	let EMPTY = ""
	let taskLocoApi: TaskLocoApi = TaskLocoApiManager()
	
	func login(username: String, password: String) -> Observable<UserInfo> {
		return taskLocoApi.login(username: username, password: password)
			.map({ (userResponse) -> UserInfo in
				self.preferences.set(userResponse.data?.apiKey, forKey: AuthConstants.apiKeyTag)
				return userResponse.data!
			})
	}
	
	func signUp(userInfo: UserInfo) {
		preferences.set("Test Key", forKey: AuthConstants.apiKeyTag)
	}
	
	func logout(username: String) {
		
	}
	
	func provideApiKey() -> String {
		return preferences.string(forKey: AuthConstants.apiKeyTag) ?? AuthConstants.noApiKey
	}
}
