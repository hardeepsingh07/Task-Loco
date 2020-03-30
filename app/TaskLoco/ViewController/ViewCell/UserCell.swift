//
//  UserCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
	
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var image: UIButton!
    
    
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func updateCell(_ userHeader: UserHeader) {
        self.name.text = userHeader.name
        self.username.text = userHeader.username
		self.image.backgroundColor = generateRandomColor()
		self.image.setTitle(String(userHeader.name.first ?? General.x), for: .normal)
	}
	
	func generateRandomColor() -> UIColor {
		return [ColorConstants.primaryColorAlpha, ColorConstants.primaryColor, ColorConstants.lightBlue, ColorConstants.lightYellow, ColorConstants.lightGreen, ColorConstants.lightRed, ColorConstants.lightGrey].randomElement()!
	}
}
