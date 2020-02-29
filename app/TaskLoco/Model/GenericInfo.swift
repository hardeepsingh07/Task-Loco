//
//  GenericInof.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import Foundation

struct ResponseError: Codable, Error {
	let name: String
	let message: String
}
