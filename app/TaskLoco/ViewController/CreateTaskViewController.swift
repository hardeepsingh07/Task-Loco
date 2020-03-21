//
//  AlertDialogViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/20/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit


class CreateTaskViewController: UIViewController {
	
    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var inProgressButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskResponsible: UITextField!
    @IBOutlet weak var taskCompletedBy: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
		super.viewDidLoad()
		taskCompletedBy.showDatePicker()
		taskTitle.bottomBorder(uiColor: UIColor.lightGray)
		taskResponsible.bottomBorder(uiColor: UIColor.lightGray)
		taskCompletedBy.bottomBorder(uiColor: UIColor.lightGray)
		taskDescription.bottomBorder(uiColor: UIColor.lightGray)
		
        pendingButton.backgroundColor = Status.pending.color
        inProgressButton.backgroundColor = Status.inProgress.color
        completedButton.backgroundColor = Status.completed.color
		updateStatusView(Status.pending)
	}
    
    @IBAction func highPriorityButtonAction(_ sender: Any) {
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
    @IBAction func inProgressButtonAction(_ sender: Any) {
		updateStatusView(.inProgress)
    }
    @IBAction func completedButtonAction(_ sender: Any) {
		updateStatusView(.completed)
    }
	
    @IBAction func createButtonAction(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
    }
	
	private func updateStatusView(_ status: Status) {
        headerBackground.backgroundColor = status.color
        headerTitle.text = status.rawValue
		createButton.backgroundColor = status.color
    }
}
