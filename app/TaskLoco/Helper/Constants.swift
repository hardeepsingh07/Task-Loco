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
	static var homeTabBar = "HomeTabBarViewController"
	static var projectTabBar = "ProjectTabBarViewController"
	static var createTask = "TaskViewController"
	static var contentView = "ContentViewController"
	static var users = "UsersViewController"
	static var userProject = "UserProjectViewController"
	static var user = "UserViewController"
}

enum CellConstants {
	static var task = "TaskCell"
	static var archive = "ArchiveCell"
	static var user = "UserCell"
	static var add = "AddCell"
	static var project = "ProjectCell"
	static var people = "PeopleCell"
	static var userProject = "UserProjectCell"
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
	static var removeMemberTitle = "Remove Member"
	static var removeMemberMessage = "Are you sure you want to remove %@?"
	static var remove = "Remove"
	static var archive = "Archive"
	static var cancel = "Cancel"
	static var success = "Success"
	static var memberAddMessage = "%@ added successfully"
}

enum General {
	static var fourTab = "\t\t\t\t"
	static var empty = ""
	static var all = "All"
	static var x: Character = "X"
	static var projectsCount = " Projects"
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

enum Greeting {
	static var morning = "Good Morning"
	static var afternoon = "Good Afternoon"
	static var evening = "Good Evening"
	
	static var message: String {
		let dateComponents = Calendar.current.dateComponents([.hour], from: Date())
		switch dateComponents.hour! {
		case 0..<12:
			return morning
		case 12..<17:
			return afternoon
		default:
			return evening
		}
	}
}

enum UsersSelectionType {
	case single
	case multiple
	
	var message: String {
		switch self {
		case .single:
			return "Select a User"
		case .multiple:
			return "Add Users"
		}
	}
}
