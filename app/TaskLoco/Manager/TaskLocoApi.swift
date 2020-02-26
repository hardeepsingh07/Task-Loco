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
	
	func signUp(userInfo: UserInfo)
	
	func logout(username: String)
}
