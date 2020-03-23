//
//  Constants.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import DynamicColor

enum ViewController {
	static var login = "LoginViewController"
	static var signUp = "SignupViewController"
	static var tabBar = "TabBarViewController"
	static var createTask = "CreateTaskViewController"
	static var contentView = "ContentViewController"
}

enum CellConstants {
	static var today = "TodayCell"
	static var archive = "ArchiveCell"
}

enum CellType {
	case userCell
	case archiveCell
}

enum ColorConstants{
	static var primaryColorAlpha = UIColor(red:0.00, green:0.33, blue:0.58, alpha:0.8)
	static var primaryColor = UIColor(red:0.00, green:0.33, blue:0.58, alpha:1)
	static var lightBlue = DynamicColor(hexString: "#0096FF")
	static var lightYellow = DynamicColor(hexString: "#FFD479")
	static var lightGreen = DynamicColor(hexString: "#009193")
	static var lightRed = DynamicColor(hexString: "FF7E79")
	static var lightGrey = DynamicColor(hexString: "D6D6D6")
}

enum Alerts{
	static var dismiss = "Dismiss"
	static var invalidInput = "Invalid Input"
	static var inputRequired = "All Input is Required"
}

enum General {
	static var fourTab = "\t\t\t\t"
	static var empty = ""
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

enum DateFormat {
	static var monthDateCommaYear = "MMM dd, yyyy"
	static var monthDateYearDash = "MM/dd/yyyy"
}

enum DatePicker {
	static var done = "Done"
	static var cancel = "Cancel"
}

enum LayerConstants {
	static var pulse = "pulse"
}
