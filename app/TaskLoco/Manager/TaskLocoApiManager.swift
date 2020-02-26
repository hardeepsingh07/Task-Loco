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

class TaskLocoApiManager: TaskLocoApi {
	
	func login(username: String, password: String) -> Observable<UserResponse> {
		return self.request(urlRequest: EndpointData.login(username: username, password: password).urlRequest)
	}
	
	func signUp(userInfo: UserInfo) {
		
	}
	
	func logout(username: String) {
		
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
