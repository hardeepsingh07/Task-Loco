//
//  UiView.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/2/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable
class DesignableView: UIView {}

extension UIView {
	
	@IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
	
    func fade() {
        let mask = CAGradientLayer()
		mask.startPoint = CGPoint(x: 1.0, y: 0.7)
		mask.endPoint = CGPoint(x: 0.0, y: 0.5)
        let whiteColor = UIColor.white
		mask.colors = [whiteColor.withAlphaComponent(0.0).cgColor,whiteColor.withAlphaComponent(1.0),whiteColor.withAlphaComponent(1.0).cgColor]
		mask.locations = [NSNumber(value: 0.0),NSNumber(value: 0.2),NSNumber(value: 1.0)]
        mask.frame = self.bounds
        self.layer.mask = mask
    }
	
	func cellBorder() {
		layer.masksToBounds = true
		layer.borderWidth = 0.5
        layer.cornerRadius = 10
		layer.borderColor = UIColor.lightGray.cgColor
	}
}
