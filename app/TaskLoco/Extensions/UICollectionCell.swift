//
//  UICollectionCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/9/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
	
	func applyBorder(_ color: UIColor = UIColor.lightGray, _ width: CGFloat = 1.0) {
		self.layer.borderWidth = width
		self.layer.borderColor = color.cgColor
	}
}
