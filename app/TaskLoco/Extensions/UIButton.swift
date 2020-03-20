//
//  UIButton.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/15/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

extension UIButton {
	
	func pulse(_ parentLayer: CALayer) {
		let pulse = PulseAnimation(numberOfPulse: Float.infinity, radius: 20, duration: 3, postion: self.center)
		pulse.name = LayerConstants.pulse
		parentLayer.insertSublayer(pulse, below: parentLayer)
	}
	
	func removePulse(_ parentLayer: CALayer) {
		parentLayer.sublayers?.forEach({ (layer) in if(layer.name == LayerConstants.pulse) { layer.removeFromSuperlayer() } })
	}
	
	func isPulsing(_ parentLayer: CALayer) -> Bool {
		return parentLayer.sublayers?.filter({ return $0.name == LayerConstants.pulse }).count ?? 0 > 0
	}
}

