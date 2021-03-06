//
//  NetworkInterceptor.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/1/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import Alamofire


class NetworkInterceptor: RequestInterceptor {
	
	private let authManager: UserManger
	
	init(authManager: UserManger) {
		self.authManager = authManager
	}
	
	func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
		let authenticate = urlRequest.url?.absoluteString.contains(PathConstants.login) == false
		do {
			if(authenticate) {
				let params: Parameters = [QueryConstants.apiKey: authManager.provideApiKey()]
				let newRequest = try URLEncoding(destination: .queryString).encode(urlRequest, with: params)
				print("\(newRequest.httpMethod ?? ""): \(newRequest)")
				completion(.success(newRequest))
			} else {
				print("\(urlRequest.httpMethod ?? ""): \(urlRequest)")
				completion(.success(urlRequest))
			}
		} catch {
			completion(.failure(error))
		}
	}
}
