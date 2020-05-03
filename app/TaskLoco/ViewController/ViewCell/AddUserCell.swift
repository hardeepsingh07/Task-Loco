//
//  AddUserCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/9/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class AddUserCell: UICollectionViewCell {
	
    @IBOutlet weak var image: UIButton!
    @IBOutlet weak var label: UILabel!
    
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func updateCell() {
        self.image.backgroundColor = TL.userManager.provideSecondaryColor() ?? ColorConstants.primaryColor
        self.label.primaryColor()
	}
}
