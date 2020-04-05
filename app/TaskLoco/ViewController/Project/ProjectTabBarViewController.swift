//
//  TabBarController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/20/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

enum Tab: Int {
	case home = 0
	case team = 1
	case create = 2
	case archive = 3
	case setting = 4
}

class ProjectTabBarViewController: UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self
	}
	
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		if viewController is TaskViewController {
			navigateToTaskAlertSheet(ViewController.createTask)
			return false
		}
		return true
	}

}
