//
//  TeamTaskViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/25/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class TeamTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var priorityMenuButton: UIButton!
    @IBOutlet weak var priorityButtonsStack: UIStackView!
    @IBOutlet weak var statusMenuButton: UIButton!
    @IBOutlet weak var statusButtonStack: UIStackView!
    @IBOutlet weak var userMenuButton: UIButton!
    
    @IBOutlet weak var teamTaskTableView: UITableView!
    
    @IBOutlet weak var membersCount: UILabel!
    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var completeCount: UILabel!
	
    @IBOutlet weak var priorityFilterText: UILabel!
    @IBOutlet weak var statusFilterText: UILabel!
    @IBOutlet weak var usernameFilterText: UILabel!
	
	private let disposeBag = DisposeBag()
	private var tasks: [Task] = []
	private var team: [UserHeader] = []
    private var currentStatus: Status? = nil
    private var currentPriority: Priority? = nil
    private var currentUsername: String? = nil
    private var menuOpen: Bool = false
    
    override func viewDidLoad() {
		super.viewDidLoad()
		
        priorityFilterText.text = currentPriority?.rawValue ?? General.all
		statusFilterText.isHidden = currentStatus == nil
        statusFilterText.text = currentStatus?.rawValue ?? General.all
		usernameFilterText.isHidden = currentUsername == nil
        usernameFilterText.text = currentPriority?.rawValue ?? General.all
        
        teamTaskTableView.dataSource = self
        teamTaskTableView.delegate = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		updateTaskView()
	}
    
    private func updateTaskView() {
        TL.taskLocoApi.filterTask(status: currentStatus, priority: currentPriority, username: currentUsername)
            .observeOn(MainScheduler.instance)
            .mapToHandleResponse()
            .subscribe(onNext: { tasks  in
                self.tasks = tasks
                self.teamTaskTableView.reloadData()
                self.updateFilterText()
				self.updateAnalyticsView()
            }, onError: { error in
                self.handleError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateFilterText() {
        priorityFilterText.text = currentPriority?.rawValue ?? General.all
        statusFilterText.isHidden = currentStatus == nil
        statusFilterText.text = currentStatus?.rawValue ?? General.all
        usernameFilterText.isHidden = currentUsername == nil
        usernameFilterText.text = currentPriority?.rawValue ?? General.all
    }
    
    private func updateAnalyticsView() {
		membersCount.text = String(team.count) + TaskAnalytics.member
		taskCount.text = String(tasks.count) + TaskAnalytics.tasks
		completeCount.text = String(tasks.filter({ $0.status == .completed}).count) + TaskAnalytics.completed
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.task, for: indexPath) as! TaskCell
		cell.updateCell(self.tasks[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		navigateToAlertSheet(ViewController.createTask, self.tasks[indexPath.row])
	}
	
    
    @IBAction func filterMenuButtonSelected(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            toggleFilterMenu()
			if(!menuOpen) { self.updateTaskView() }
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
		switch sender.tag {
        case 0:
			currentPriority = Priority.high
        case 1:
            currentPriority = Priority.standard
        default:
            print("Unknown Button Tag: \(sender.tag)")
        }
		priorityMenuButton.setTitle(String(currentPriority?.rawValue.first ?? "P"), for: .normal)
		priorityMenuButton.backgroundColor = currentPriority?.color ?? Priority.high.color
		togglePanelMenu(hidePriority: true, hideStatus: true)
    }
    
    @IBAction func statusButtonSelected(_ sender: UIButton) {
        switch sender.tag {
        case 0:
			currentStatus = Status.pending
            break;
        case 1:
            currentStatus = Status.inProgress
            break;
        case 2:
            currentStatus = Status.completed
            break;
        default:
            print("Unknown Button Tag: \(sender.tag)")
        }
		statusMenuButton.setTitle(String(currentStatus?.rawValue.first ?? "S"), for: .normal)
		statusMenuButton.backgroundColor = currentStatus?.color ?? Status.pending.color
		togglePanelMenu(hidePriority: true, hideStatus: true)
    }
    
    private func toggleFilterMenu() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.priorityMenuButton.isHidden = !self.priorityMenuButton.isHidden
            self.statusMenuButton.isHidden = !self.statusMenuButton.isHidden
            self.userMenuButton.isHidden = !self.userMenuButton.isHidden
			self.togglePanelMenu(hidePriority: true, hideStatus: true)
            self.menuOpen = !self.menuOpen
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
