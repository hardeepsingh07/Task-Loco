//
//  UILabel.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/7/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

extension UILabel {
	
	func handleColor(gradient: UIGradient?) {
		self.textColor = gradient?.metadata.isPredominantlyLight == true ? UIColor.black : UIColor.white
	}
	
	func primaryColor() {
		self.textColor = TL.userManager.providePrimaryColor()
	}
	
	func secondaryColor() {
		self.textColor = TL.userManager.provideSecondaryColor()
	}
}
