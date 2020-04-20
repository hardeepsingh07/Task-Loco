//
//  SignupViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class SignupViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		nameTF.bottomBorder()
		emailTF.bottomBorder()
		usernameTF.bottomBorder()
		passwordTF.bottomBorder()
    }
	
	@IBAction func signUpAction(_ sender: Any) {
		if(validateInput(textFields: nameTF, emailTF, usernameTF, passwordTF)) {
			TL.userManager.signUp(name: nameTF.text!, email: emailTF.text!, username: usernameTF.text!, password: passwordTF.text!)
				.observeOn(MainScheduler.instance)
				.subscribe(onNext: { userInfo in
					self.navigateTo(UITabBarController.self, ViewController.homeTabBar, true)
				}, onError: { error in
					self.handleError(error)
				})
				.disposed(by: disposeBag)
		}
	}
    
    @IBAction func loginAction(_ sender: Any) {
		self.dismiss(animated: true)
    }
}
