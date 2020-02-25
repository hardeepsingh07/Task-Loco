//
//  TaskLocoApiManager.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import os

extension URLSession {
	func requestData(urlRequest: URLRequest, result: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask? {
		return dataTask(with: urlRequest) { (data, response, error) in
			if let error = error { result(.failure(error)) }
			if let data = data { result(.success(data)) }
		}
	}
}

class TaskLocoApiManager: TaskLocoApi {
	
	let BASE_URL = "http://localhost:8080"
	let USER_PATH = "/user"
	let POST = "POST"
	let GET = "GET"
	let DELETE = "DELETE"
	
	func login(userLoginRequest: UserLoginRequest, completion: @escaping (Result<UserResponse, Error>) -> ()) {
		let loginUrl = BASE_URL + USER_PATH + "/login"
		let jsonBody = try? JSONEncoder().encode(userLoginRequest)
		guard let urlRequest = createBodyUrlRequest(url: loginUrl, data: jsonBody) else { return }
		
		URLSession.shared.requestData(urlRequest: urlRequest) { (result) in
			switch(result) {
			case .success(let data):
				let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data)
				guard let response = userResponse else { return }
				completion(.success(response))
			case .failure(let error):
				completion(.failure(error))
			}
			}!.resume()
	}
	
	func signUp(userInfo: UserInfo) {
		
	}
	
	func logout(username: String) {
		
	}
	
	func createBodyUrlRequest(url: String, data: Data?) -> URLRequest? {
		guard let requestUrl = URL(string: url) else { return nil }
		var urlRequest = URLRequests(url: requestUrl)
		if(data != nil) {
			urlRequest.httpMethod = POST
			urlRequest.httpBody = data
			urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
		}
		return urlRequest
	}
}
