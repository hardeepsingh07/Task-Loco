//
//  TodayViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
	
	let authManager = AuthManager()
	
	override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		messageAlert("Stored Data", "\(authManager.provideUsername()):\(authManager.provideApiKey())")
	}
}

