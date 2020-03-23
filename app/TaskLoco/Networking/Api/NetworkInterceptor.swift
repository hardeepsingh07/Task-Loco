//
//  NetworkInterceptor.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/1/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import Alamofire

private enum QueryConstants {
	static var apiKey = "apiKey"
}

class NetworkInterceptor: RequestInterceptor {
	
	private let authManager: UserManger
	
	init(authManager: UserManger) {
		self.authManager = authManager
	}
	
	func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
		print("\(urlRequest.httpMethod ?? ""): \(urlRequest)")
		let params: Parameters = [QueryConstants.apiKey: authManager.provideApiKey()]

		do {
			let newRequest = try URLEncoding.default.encode(urlRequest, with: params)
			print("\(newRequest.httpMethod ?? ""): \(newRequest)")
			completion(.success(newRequest))
		} catch {
			completion(.failure(error))
		}
	}
}
