//
//  SettingsViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
	
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var closedSwitch: UISwitch!
    
    override func viewDidLoad() {
		super.viewDidLoad()
		let userHeader = TL.userManager.provideUserHeader()
		name.text = userHeader.name
		username.text = userHeader.username
        closedSwitch.isOn = TL.userManager.isClosedEnabled()
	}
    
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
		TL.userManager.updateClosedSetting(enabled: sender.isOn)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
		navigateTo(LoginViewController.self, ViewController.login, true)
    }
}
