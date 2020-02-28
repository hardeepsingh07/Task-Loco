//
//  UIViewControllerExtension.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func fullScreen() -> UIViewController {
		self.modalPresentationStyle = .fullScreen
		return self
	}
	
	func messageAlert(_ title: String, _ message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: Alerts.dismiss, style: .default))
		self.present(alertController, animated: true)
	}
	
	func validateInput(textFields: UITextField...) -> Bool {
		for field in textFields {
			if(field.text == nil && field.text!.isEmpty) {
				messageAlert(Alerts.invalidInput, Alerts.inputRequired)
				return false
			}
		}
		return true
	}
	
	func navigateTo<T: UIViewController>(_ type: T.Type, _ viewController: String) {
		let signupViewController = self.storyboard?.instantiateViewController(withIdentifier: viewController) as! T
		self.present(signupViewController.fullScreen(), animated: true)
	}
	
	func handleError(_ error: Error) {
		let error = error as? ResponseError ?? ErrorConstants.defaultError(error.localizedDescription)
		self.messageAlert(error.name, error.message)
	}
}
