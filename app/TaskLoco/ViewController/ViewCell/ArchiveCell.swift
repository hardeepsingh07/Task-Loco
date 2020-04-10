//
//  ArchiveCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/24/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class ArchiveCell: UICollectionViewCell {
	
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskResponsible: UILabel!
    
    override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func updateCell(_ task: Task) {
		taskTitle.primaryColor()
		date.primaryColor()
		month.secondaryColor()
		
        date.text = task.dayOfMonth
        month.text = task.monthOfYear
        highPriorityButton.isHidden = task.priority == .standard
        taskTitle.text = task.title
        taskDescription.text = task.description
	}
}
