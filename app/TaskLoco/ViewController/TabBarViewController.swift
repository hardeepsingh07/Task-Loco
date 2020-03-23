//
//  TabBarController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/20/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self
	}
	
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		if viewController is CreateTaskViewController {
			navigateToAlertSheet(ViewController.createTask)
			return false
		}
		return true
	}

}
