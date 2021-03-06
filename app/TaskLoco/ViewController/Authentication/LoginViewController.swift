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
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		usernameTF.bottomBorder()
		passwordTF.bottomBorder()
		usernameTF.text = "hardeep"
		passwordTF.text = "hardeep"
	}
    
	@IBAction func loginAction(_ sender: Any) {
		if(validateInput(textFields: usernameTF, passwordTF)) {
			TL.userManager.login(username: usernameTF.text!, password: passwordTF.text!)
				.observeOn(MainScheduler.instance)
				.subscribe(onNext: { userInfo in
					self.navigateTo(UITabBarController.self, ViewController.homeTabBar, true)
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

