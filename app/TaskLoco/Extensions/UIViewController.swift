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
	
	private static var picker = UIPickerView.init()
	private static var toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
	
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
	
	func confirmationAlert(archive: @escaping (_ action: UIAlertAction) -> Void, cancel: @escaping (_ action: UIAlertAction) -> Void) {
		let refreshAlert = UIAlertController(title: Alerts.confirmationTitle, message: Alerts.confirmationMessage, preferredStyle: UIAlertController.Style.alert)
		refreshAlert.addAction(UIAlertAction(title: Alerts.archive, style: .default, handler: archive))
		refreshAlert.addAction(UIAlertAction(title: Alerts.cancel, style: .cancel, handler: cancel))
		self.present(refreshAlert, animated: true)
	}
	
	func removeAlert(_ userHeader: UserHeader, remove: @escaping (_ action: UIAlertAction) -> Void) {
		let refreshAlert = UIAlertController(title: Alerts.removeMemberTitle, message: String(format: Alerts.removeMemberMessage, userHeader.name), preferredStyle: UIAlertController.Style.alert)
		refreshAlert.addAction(UIAlertAction(title: Alerts.remove, style: .destructive, handler: remove))
		refreshAlert.addAction(UIAlertAction(title: Alerts.cancel, style: .cancel, handler: nil))
		self.present(refreshAlert, animated: true)
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
	
	func navigateToTaskAlertSheet(_ vcIdentifier: String, _ task: Task? = nil) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: vcIdentifier) as! TaskViewController
		viewController.currentTaskInfo = task
		showAlertSheet(viewController: viewController)
	}
	
	func navigateToUsersAlertSheet(_ vcIdentifier: String, _ userSelectionType: UsersSelectionType, _ onSelectionDelegate: OnSelectionDelegate) {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: vcIdentifier) as! UsersViewController
		viewController.userSelectionType = userSelectionType
		viewController.onSelectionDelegate = onSelectionDelegate
		showAlertSheet(viewController: viewController)
	}
	
	private func showAlertSheet(viewController: UIViewController) {
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
	
	func showPicker() -> UIPickerView? {
		UIViewController.picker.backgroundColor = UIColor.white
		UIViewController.picker.autoresizingMask = .flexibleWidth
		UIViewController.picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
		self.view.addSubview(UIViewController.picker)

		UIViewController.toolBar.setItems([UIBarButtonItem(title: Picker.finish, style: .plain, target: self, action: #selector(onFinish))], animated: false)
		self.view.addSubview(UIViewController.toolBar)
		return UIViewController.picker
	}
	
	@objc func onFinish() {
		UIViewController.picker.removeFromSuperview()
		UIViewController.toolBar.removeFromSuperview()
	}
	
	private func addDirectionConstraint(_ view: UIView, _ secondView: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: constrait, multiplier: 1, constant: constant)
	}
	
	private func addLayoutConstraint(_ view: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
	}
}
