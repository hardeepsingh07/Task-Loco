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
	
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
	
	let disposeBag = DisposeBag()
	let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		username.bottomBorder(uiColor: UIColor.white)
		password.bottomBorder(uiColor: UIColor.white)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let username = username.text else {return}
        guard let password = password.text else {return}
        authManager.login(username: username, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { userInfo in
                print(userInfo)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
	
	
    @IBAction func signUpAction(_ sender: Any) {
		let signupViewController = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerConstants.signupViewController) as! SignupViewController
		self.present(signupViewController, animated: true)
    }
}

