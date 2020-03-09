//
//  GenericInof.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

protocol Response: Codable {
	var responseCode: Int { get }
	var message: String { get }
	associatedtype CodableType
	var data: CodableType? { get }
	var error: ResponseError? { get }
}

struct ResponseError: Codable, Error {
	let name: String
	let message: String
}
