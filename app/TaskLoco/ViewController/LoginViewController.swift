//
//  ViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

private enum LoginViewConstants {
	static var username = "Username"
	static var password = "Password"
}

class LoginViewController: UIViewController {
	
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
	let disposeBag = DisposeBag()
	let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		usernameTF.bottomBorder(uiColor: UIColor.white)
		passwordTF.bottomBorder(uiColor: UIColor.white)
    }
    
	@IBAction func loginAction(_ sender: Any) {
		if(validateInput(textFields: usernameTF, passwordTF)) {
			authManager.login(username: usernameTF.text!, password: passwordTF.text!)
				.observeOn(MainScheduler.instance)
				.subscribe(onNext: { userInfo in
					self.navigateTo(UITabBarController.self, ViewController.tabBar, true)
				}, onError: { error in
					self.handleError(error)
				})
				.disposed(by: disposeBag)
		}
	}
	
	
    @IBAction func signUpAction(_ sender: Any) {
		self.navigateTo(SignupViewController.self, ViewController.signUp)
    }
}

