//
//  RandientView.swift
//  Randient
//
//  Created by Merrick Sapsford on 09/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

open class RandientView: GradientView {
    
    open private(set) var gradient: UIGradient!
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        randomize(animated: true)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        randomize(animated: true)
    }
    
    @discardableResult
    open func randomize(animated: Bool, completion: (() -> Void)? = nil) -> UIGradient {
        let gradient = Randient.randomize()
        update(for: gradient,
               animated: animated,
               completion: completion)
        return gradient
    }
        
	func update(for gradient: UIGradient, animated: Bool, completion: (() -> Void)? = nil) {
        self.gradient = gradient
        setGradient(gradient,
                    animated: animated,
                    completion: completion)
    }
}
