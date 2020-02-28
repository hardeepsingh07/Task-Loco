//
//  TaskLocoApiManager.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import os
import RxSwift
import Alamofire

enum ResponseCode {
	static var success = 200
	static var error = 250
}

class TaskLocoApiManager: TaskLocoApi {
	
	func login(username: String, password: String) -> Observable<UserResponse> {
		return self.request(urlRequest: EndpointData.login(username: username, password: password).urlRequest)
	}
	
	func signUp(name: String, email: String, username: String, password: String) -> Observable<UserResponse> {
		return self.request(urlRequest: EndpointData.signUp(name: name, email: email, username: username, password: password).urlRequest)
	}
	
	func logout(username: String) -> Observable<UserResponse> {
		return self.request(urlRequest: EndpointData.logout(username: username).urlRequest)
	}
	
	private func request<T: Codable>(urlRequest: URLRequest) -> Observable<T>  {
		return Observable<T>.create { observer in
			let request = AF.request(urlRequest).responseDecodable { (response: DataResponse<T, AFError>) in
				switch response.result {
				case .success(let data):
					observer.onNext(data)
				case .failure(let error):
					observer.onError(error)
				}
			}
			return Disposables.create { request.cancel() }
		}
	}
}

struct APIError {
	let name: String
	let message: String
}
