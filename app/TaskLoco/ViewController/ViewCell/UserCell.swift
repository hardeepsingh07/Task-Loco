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
    @IBOutlet weak var letter: UILabel!
    
    
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	
	func updateCell(_ userHeader: UserHeader, _ selectionColor: UIColor? = TL.userManager.providePrimaryColor()) {
		self.letter.textColor = selectionColor
		
        self.name.text = userHeader.name
        self.username.text = userHeader.username
        self.letter.text = String(userHeader.name.first ?? General.x)
	}
}
