//
//  TaskCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/29/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var dateOfMonth: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var lineDivider: UIView!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var responsible: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var statusBackground: DesignableView!
    @IBOutlet weak var highPriorityButton: UIButton!
    
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
    
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	func updateView(_ task: Task) {
		dayOfWeek.text = task.dayOfWeek
		dateOfMonth.text = task.dayOfMonth
		month.text = task.monthOfYear
		taskTitle.text = task.title
		taskDescription.text = task.description
		responsible.text = task.responsible
		status.text = task.status.rawValue
		statusBackground.backgroundColor = task.status.color
		indicateHighPriority(task.priority)
	}
	
	private func indicateHighPriority(_ priority: Priority) {
		let layerName = "Pulsing"
		if(priority == .high) {
			let pulse = PulseAnimation(numberOfPulse: Float.infinity, radius: 20, duration: 2.5, postion: highPriorityButton.center)
			pulse.name = layerName
			highPriorityButton.isHidden = false
			contentView.layer.insertSublayer(pulse, below: highPriorityButton.layer)
		} else {
			highPriorityButton.isHidden = true
			contentView.layer.sublayers?.forEach({ (layer) in
				if(layer.name == layerName) {
					layer.removeFromSuperlayer()
				}
			})
		}
	}
}
