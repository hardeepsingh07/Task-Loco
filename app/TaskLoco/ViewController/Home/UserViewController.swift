//
//  UserViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/19/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class UserViewController: UIViewController {
	
    @IBOutlet weak var greetings: UILabel!
    @IBOutlet weak var projectCount: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    
    private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
		super.viewDidLoad()
		self.greetings.text = Greeting.message
	}
    
    override func viewDidAppear(_ animated: Bool) {
        TL.taskLocoApi.updateWithProject(username: TL.userManager.provideUserHeader().username)
			.mapToHandleResponse()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { userProject in
				self.projectCount.text = String(userProject.project.count) + General.projectsCount
				self.name.text = userProject.user.name
				self.username.text = userProject.user.username
				self.email.text = userProject.user.email
            }, onError: {error in
				self.handleError(error)
            }).disposed(by: disposeBag)
    }
	
	func initLabelBorder() {
		name.bottomBorder(uiColor: UIColor.lightGray)
		username.bottomBorder(uiColor: UIColor.lightGray)
		email.bottomBorder(uiColor: UIColor.lightGray)
	}
    
    @IBAction func logout(_ sender: Any) {
		self.navigateTo(UserViewController.self, ViewController.user, true)
    }
}
