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
	static var createTask = "TaskViewController"
	static var contentView = "ContentViewController"
}

enum CellConstants {
	static var task = "TaskCell"
	static var archive = "ArchiveCell"
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
	static var confirmationTitle = "Task is Completed"
	static var confirmationMessage = "Do you want to archive the task?"
	static var archive = "Archive"
	static var cancel = "Cancel"
}

enum General {
	static var fourTab = "\t\t\t\t"
	static var empty = ""
	static var all = "All"
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

enum Picker {
	static var done = "Done"
	static var cancel = "Cancel"
	static var finish = "Finish"
}

enum LayerConstants {
	static var pulse = "pulse"
}

enum ButtonConstants {
	static var create = "Create"
	static var update = "Update"
	static var reassign = "Re-Assign"
}

enum TaskAnalytics {
	static var member = " Member"
	static var tasks = " Tasks"
	static var completed = " Completed"
}
