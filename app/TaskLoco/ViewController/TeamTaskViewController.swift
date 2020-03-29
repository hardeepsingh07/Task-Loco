//
//  TeamTaskViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/25/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class TeamTaskViewController: UIViewController {
	
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var priorityMenuButton: UIButton!
    @IBOutlet weak var priorityButtonsStack: UIStackView!
    @IBOutlet weak var statusMenuButton: UIButton!
    @IBOutlet weak var statusButtonStack: UIStackView!
    @IBOutlet weak var userMenuButton: UIButton!
    
    override func viewDidLoad() {
		super.viewDidLoad()
	}
    
    @IBAction func filterMenuButtonSelected(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            toggleFilterMenu()
            break
        case 1:
			togglePanelMenu(hidePriority: !self.priorityButtonsStack.isHidden, hideStatus: true)
            break
        case 2:
			togglePanelMenu(hidePriority: true, hideStatus: !self.statusButtonStack.isHidden)
            break
        case 3:
            showUserPicker()
        default:
            print("Unknown Button Tag: \(sender.tag)")
        }
    }
    
    @IBAction func priorityButtonSelected(_ sender: UIButton) {
		var priority: Priority
		switch sender.tag {
        case 0:
			priority = Priority.high
        case 1:
            priority = Priority.standard
        default:
			priority = Priority.none
            print("Unknown Button Tag: \(sender.tag)")
        }
		priorityMenuButton.setTitle(String(priority.rawValue.first ?? "P"), for: .normal)
		priorityMenuButton.backgroundColor = priority.color
		togglePanelMenu(hidePriority: true, hideStatus: true)
    }
    
    @IBAction func statusButtonSelected(_ sender: UIButton) {
		var status: Status
        switch sender.tag {
        case 0:
			status = Status.pending
            break;
        case 1:
            status = Status.inProgress
            break;
        case 2:
            status = Status.completed
            break;
        default:
			status = Status.none
            print("Unknown Button Tag: \(sender.tag)")
        }
		statusMenuButton.setTitle(String(status.rawValue.first ?? "S"), for: .normal)
		statusMenuButton.backgroundColor = status.color
		togglePanelMenu(hidePriority: true, hideStatus: true)
    }
    
    private func toggleFilterMenu() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.priorityMenuButton.isHidden = !self.priorityMenuButton.isHidden
            self.statusMenuButton.isHidden = !self.statusMenuButton.isHidden
            self.userMenuButton.isHidden = !self.userMenuButton.isHidden
			self.togglePanelMenu(hidePriority: true, hideStatus: true)
        })
    }
	
	private func togglePanelMenu(hidePriority: Bool, hideStatus: Bool) {
		UIView.animate(withDuration: 0.5, animations: {
			self.priorityButtonsStack.isHidden = hidePriority
			self.statusButtonStack.isHidden = hideStatus
		})
	}
    
    private func showUserPicker() {
        
    }
}
