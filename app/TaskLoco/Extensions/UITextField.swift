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
}
