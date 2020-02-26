//
//  Endpoint.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation
import Alamofire

protocol Endpoint {
	var baseUrl: String { get }
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var headers: HTTPHeaders { get }
	var encoding: ParameterEncoding { get }
	var parameters: Parameters { get }
	var url: URL { get }
	var urlRequest: URLRequest { get }
}
