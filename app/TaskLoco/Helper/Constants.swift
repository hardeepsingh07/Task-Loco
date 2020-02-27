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

//extension ViewController {
//
//	func name() -> String {
//		switch self {
//		case .login:
//			return "LoginViewController"
//		case .signUp:
//			return "SignupViewController"
//		case .home:
//			return "HomeViewController"
//		}
//	}
//
//	func type<T>() -> T.Type where T:UIViewController {
//		switch self {
//		case .login:
//			return LoginViewController.self
//		case .signUp:
//			return SignupViewController.self
//		case .home:
//			return HomeViewController.self
//		}
//	}
//}

enum ColorConstants{
	static var primaryColorAlpha = UIColor(red:0.00, green:0.33, blue:0.58, alpha:0.8)
	static var primaryColor = UIColor(red:0.00, green:0.33, blue:0.58, alpha:1)
}

enum Alerts{
	static var dismiss = "Dismiss"
	static var invalidInput = "Invalid Input"
	static var inputRequired = "All Input is Required"
}
