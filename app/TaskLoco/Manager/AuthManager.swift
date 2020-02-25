//
//  AuthManager.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import os

class AuthManager {
	
	let preferences = UserDefaults.standard
	let API_KEY_TAG = "user-api-key"
	let NO_API_KEY = "No Api Key"
	let EMPTY = ""
	let taskLocoApi: TaskLocoApi = TaskLocoApiManager()
	
	func login(username: String, password: String) {
		let userLoginRequest = UserLoginRequest(username: username, password: password)
		taskLocoApi.login(userLoginRequest: userLoginRequest) { (completion) in
			switch (completion) {
			case .success(let userResponse):
				print(userResponse)
//				self.preferences.set(userResponse.data.apiKey, forKey: self.API_KEY_TAG)
			case .failure(let error):
				print("Login Failed: \(error.localizedDescription)")
			}
		}
	}
	
	func signUp(userInfo: UserInfo) {
		
		preferences.set("Test Key", forKey: API_KEY_TAG)
	}
	
	func logout(username: String) {
		
	}
	
	func provideApiKey() -> String {
		return preferences.string(forKey: API_KEY_TAG) ?? NO_API_KEY
	}
}
