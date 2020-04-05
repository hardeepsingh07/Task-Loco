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
    @IBOutlet weak var cellBackground: UIView!
    
    override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func updateCell(_ project: Project) {
		self.projectId.text = project.projectId
		self.projectName.text = project.name
		self.projectDescription.text = project.description
	}
}
