//
//  TaskLocoApi.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

protocol TaskLocoApi {
	
	func login(userLoginRequest: UserLoginRequest, completion: @escaping (Result<UserResponse, Error>) -> Void)
	
	func signUp(userInfo: UserInfo)
	
	func logout(username: String)
}
