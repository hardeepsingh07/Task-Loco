//
//  TaskLocoProvider.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/1/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import Alamofire

class TL {
	
	public static var preferences = UserDefaults.standard
	
	private static var networkInterceptor = NetworkInterceptor(authManager: authManager)
	
	public static var session = Session(interceptor: networkInterceptor)
	
	public static var taskLocoApi: TaskLocoApi = TaskLocoApiManager()

	public static var authManager = AuthManager(preferences: preferences, taskLocoApi: taskLocoApi)
}
