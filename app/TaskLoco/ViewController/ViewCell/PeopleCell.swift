//
//  PeopleCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/10/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class PeopleCell: UICollectionViewCell {
	
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func updateCell(_ userHeader: UserHeader) {
        self.name.text = userHeader.name
        self.username.text = userHeader.username
        self.letter.text = String(userHeader.name.first ?? General.x)
	}
}
