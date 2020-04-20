//
//  UserProjectCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/19/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class UserProjectCell: UICollectionViewCell {
	
    
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var projectId: UILabel!
    override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func updateCell(_ project: Project) {
		self.letter.handleColor(gradient: TL.userManager.projectGradient)
		self.name.handleColor(gradient: TL.userManager.projectGradient)
		self.projectId.handleColor(gradient: TL.userManager.projectGradient)
		
        self.name.text = project.name
        self.projectId.text = project.projectId.uppercased()
        self.letter.text = String(project.name.first ?? General.x)
	}
}
