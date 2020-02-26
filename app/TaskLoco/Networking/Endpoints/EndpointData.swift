//
//  EndpointData.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import Alamofire

enum EndpointData{
	case login(username: String, password: String)
	case signUp
	case logout(username: String)
}

private enum PathConstants {
	static var root = "/"
	static var login = "/user/login"
	static var signUp = "/user"
	static var logout = "/user/logout"
}

private enum UrlConstants {
	static var baseUrl = "http://localhost:8080"
	static var contentType = "Content-Type"
	static var applicationJson = "application/json"
}

private enum ParameterConstants {
	static var username = "username"
	static var password = "password"
}

extension EndpointData: Endpoint {
	
	var baseUrl: String {
		return UrlConstants.baseUrl
		
	}
	
	var path: String {
		switch self {
		case .login:
			return PathConstants.login
		case .signUp:
			return PathConstants.signUp
		case .logout:
			return PathConstants.logout
		default:
			return PathConstants.root
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		case .login, .signUp, .logout:
			return .post
		default:
			return .get
		}
	}
	
	var headers: HTTPHeaders {
		return [UrlConstants.contentType: UrlConstants.applicationJson]
	}
	
	var encoding: ParameterEncoding {
		return JSONEncoding.default
	}
	
	var parameters: Parameters {
		switch self {
		case .login(let username, let password):
			return [ParameterConstants.username: username,
					ParameterConstants.password: password]
		case .logout(let username):
			return [ParameterConstants.username: username]
		default:
			return [:]
		}
	}
	
	var url: URL {
		return URL(string: baseUrl + path)!
	}
	
	var urlRequest: URLRequest {
		var urlRequest = URLRequest(url: url)
		urlRequest.headers = headers
		urlRequest.method = httpMethod
		return try! encoding.encode(urlRequest, with: parameters)
	}
}


