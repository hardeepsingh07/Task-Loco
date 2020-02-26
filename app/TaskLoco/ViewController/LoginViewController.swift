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
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signUp: UIButton!
	
	let disposeBag = DisposeBag()
	let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		username
			.border(uiColor: UIColor.white)
			.padding(padding: 10)
			.placeholder(text: LoginViewConstants.username)
		password
			.border(uiColor: UIColor.white)
			.padding(padding: 10)
			.placeholder(text: LoginViewConstants.password)
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
}

extension UITextField {
	func padding(padding: CGFloat) -> UITextField {
		let viewHeight: CGFloat = self.frame.height
		let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: padding, height: viewHeight))
        self.leftView = paddingView;
		self.leftViewMode = .always;
        self.rightView = paddingView;
		self.rightViewMode = .always;
		return self
	}
	
	func border(uiColor: UIColor) -> UITextField {
		self.layer.borderColor = uiColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
		return self
    }
	
	func placeholder(text: String) -> UITextField {
		self.attributedPlaceholder = NSAttributedString(string:text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
		return self
	}
}

