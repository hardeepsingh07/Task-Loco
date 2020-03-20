//
//  CreateTaskViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/19/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//
import UIKit

class CreateTaskViewController: UIViewController {
	
    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskResponsible: UITextField!
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var inProgressButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var taskCompleteBy: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var createButton: UIButton!
	
	private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
		super.viewDidLoad()
		taskCompleteBy.showDatePicker()
		taskTitle.bottomBorder(uiColor: UIColor.lightGray)
		taskResponsible.bottomBorder(uiColor: UIColor.lightGray)
		taskCompleteBy.bottomBorder(uiColor: UIColor.lightGray)
		taskDescription.bottomBorder(uiColor: UIColor.lightGray)
		
        pendingButton.backgroundColor = Status.pending.color
        inProgressButton.backgroundColor = Status.inProgress.color
        completedButton.backgroundColor = Status.completed.color
		updateStatusView(Status.pending)
	}
    
    @IBAction func highPriorityAction(_ sender: UIButton) {
		if(highPriorityButton.isPulsing(headerBackground.layer)) {
			highPriorityButton.backgroundColor = ColorConstants.lightGrey
			highPriorityButton.removePulse(headerBackground.layer)
		} else {
			highPriorityButton.backgroundColor = ColorConstants.lightRed
			highPriorityButton.pulse(headerBackground.layer)
		}
    }
    
    @IBAction func pendingAction(_ sender: Any) {
        updateStatusView(.pending)
    }
    @IBAction func inProgressAction(_ sender: Any) {
        updateStatusView(.inProgress)
    }
    @IBAction func completedAction(_ sender: Any) {
        updateStatusView(.completed)
    }
    
    @IBAction func createAction(_ sender: Any) {
    }
    
    private func updateStatusView(_ status: Status) {
        headerBackground.backgroundColor = status.color
        headerTitle.text = status.rawValue
		createButton.backgroundColor = status.color
    }
}
