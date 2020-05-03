//
//  HomeTabBarViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 5/3/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self
	}
	
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		if viewController is CreateProjectViewController {
			navigateToProjectAlertSheet(ViewController.createProject)
			return false
		}
		return true
	}

}
