//
//  UITextFieldExtension.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/26/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

extension UITextField {

	func bottomBorder(uiColor: UIColor) {
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
		bottomLine.backgroundColor = uiColor.cgColor
		borderStyle = .none
		layer.addSublayer(bottomLine)
	}
	
	func showDatePicker() {
		TL.datePicker.datePickerMode = .date
		
		let toolbar = UIToolbar();
		toolbar.sizeToFit()
		let doneButton = UIBarButtonItem(title: DatePicker.done, style: .plain, target: self, action: #selector(donedatePicker));
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: DatePicker.cancel, style: .plain, target: self, action: #selector(cancelDatePicker));
		toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
		
		self.inputAccessoryView = toolbar
		self.inputView = TL.datePicker
	}
	
	@objc func donedatePicker() {
		let formatter = DateFormatter()
		formatter.dateFormat = DateFormat.monthDateCommaYear
		self.text = formatter.string(from: TL.datePicker.date)
		self.endEditing(true)
	}
	
	@objc func cancelDatePicker() {
		self.endEditing(true)
	}
}
