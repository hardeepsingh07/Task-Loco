//
//  Constants.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

enum ViewController {
	static var login = "LoginViewController"
	static var signUp = "SignupViewController"
	static var home = "HomeViewController"
}

enum ColorConstants{
	static var primaryColorAlpha = UIColor(red:0.00, green:0.33, blue:0.58, alpha:0.8)
	static var primaryColor = UIColor(red:0.00, green:0.33, blue:0.58, alpha:1)
}

enum Alerts{
	static var dismiss = "Dismiss"
	static var invalidInput = "Invalid Input"
	static var inputRequired = "All Input is Required"
}

enum ErrorConstants {
	static let defaultErrorTitle = "Error Occured"
	static let defaultErrorMessage = "Unknown Reasons"
	
	static func defaultError() -> ResponseError {
		return ResponseError(name: defaultErrorTitle, message: defaultErrorTitle)
	}
	
	static func defaultError(_ message: String) -> ResponseError {
		return ResponseError(name: defaultErrorTitle, message: message)
	}
}
