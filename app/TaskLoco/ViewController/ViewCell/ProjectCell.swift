//
//  ProjectCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class ProjectCell: UICollectionViewCell {
	
    @IBOutlet weak var projectId: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var projectStarred: UIImageView!
    @IBOutlet weak var gradientBackground: RandientView!
    @IBOutlet weak var firstLetter: UILabel!
    
    override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func updateCell(_ project: Project) {
		self.projectId.text = project.projectId.uppercased()
		self.projectName.text = project.name
		self.projectDescription.text = project.description
        self.firstLetter.text = String(project.name.first!)
		handleColor()
	}
	
	func handleColor() {
		let gradient = gradientBackground.randomize(animated: true)
		projectId.handleColor(gradient: gradient)
		projectName.handleColor(gradient: gradient)
		projectDescription.handleColor(gradient: gradient)
		firstLetter.handleColor(gradient: gradient)
		projectStarred.tintColor = gradient.metadata.isPredominantlyLight == true ? UIColor.black : UIColor.white
	}
}
