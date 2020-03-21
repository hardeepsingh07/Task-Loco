//
//  UIViewControllerExtension.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import UICircularProgressRing

extension UIViewController {
	
	func fullScreen() -> UIViewController {
		self.modalPresentationStyle = .fullScreen
		return self
	}
	
	func errorAlert(_ message: String) {
		messageAlert(ErrorConstants.defaultErrorTitle, message)
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
	
	func navigateTo<T: UIViewController>(_ type: T.Type, _ viewController: String, _ dismiss: Bool = false) {
		if(dismiss) { self.view.window?.rootViewController?.dismiss(animated: true) }
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: viewController) as! T
		self.present(viewController.fullScreen(), animated: true)
	}
	
	func navigateToAlertSheet<T: UIViewController>(_ type: T.Type, _ vcIdentifier: String) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: vcIdentifier) as! T
		let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alertController.setValue(viewController, forKey: ViewController.contentView)
		self.present(alertController, animated: true) {
			let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
			alertController.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
		}
	}
	
	@objc func dismissAlertController(){
		self.dismiss(animated: true, completion: nil)
	}
	
	func handleError(_ error: Error) {
		let error = error as? ResponseError ?? ErrorConstants.defaultError(error.localizedDescription)
		self.messageAlert(error.name, error.message)
	}
	
	func addProgressBar(_ attachToView: UIView) -> UICircularProgressRing {
		let progressBar = UICircularProgressRing()
		progressBar.maxValue = 100
		progressBar.style = .ontop
		progressBar.outerRingColor = UIColor.white
		progressBar.fontColor = UIColor.white
		progressBar.innerRingColor = ColorConstants.lightGreen
		progressBar.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(progressBar)
		
		view.addConstraints([addDirectionConstraint(progressBar, attachToView, .bottom, -10),
							 addDirectionConstraint(progressBar, attachToView, .right, -10),
							 addLayoutConstraint(progressBar, .width, 75),
							 addLayoutConstraint(progressBar, .height, 75)])
		return progressBar
	}
	
	private func addDirectionConstraint(_ view: UIView, _ secondView: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: constrait, multiplier: 1, constant: constant)
	}
	
	private func addLayoutConstraint(_ view: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
	}
}
