//
//  UiView.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/2/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

extension UIView {
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
}
