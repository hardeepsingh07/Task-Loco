//
//  SignupViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
	    
    override func viewDidLoad() {
        super.viewDidLoad()
		name.bottomBorder(uiColor: ColorConstants.primaryColor)
		email.bottomBorder(uiColor: ColorConstants.primaryColor)
		username.bottomBorder(uiColor: ColorConstants.primaryColor)
		password.bottomBorder(uiColor: ColorConstants.primaryColor)
    }
    @IBAction func signUpAction(_ sender: Any) {
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
		self.dismiss(animated: true)
    }
}
