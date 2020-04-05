//
//  TeamTaskViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/25/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class TeamTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
	
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var priorityMenuButton: UIButton!
    @IBOutlet weak var priorityButtonsStack: UIStackView!
    @IBOutlet weak var statusMenuButton: UIButton!
    @IBOutlet weak var statusButtonStack: UIStackView!
    @IBOutlet weak var userMenuButton: UIButton!
    @IBOutlet weak var clearMenuButton: UIButton!
    
    @IBOutlet weak var teamTaskTableView: UITableView!
    
    @IBOutlet weak var membersCount: UILabel!
    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var completeCount: UILabel!
	
    @IBOutlet weak var priorityFilterText: UILabel!
    @IBOutlet weak var statusFilterText: UILabel!
    @IBOutlet weak var usernameFilterText: UILabel!
	
	private var namesPicker: UIPickerView? = nil
	
	private let disposeBag = DisposeBag()
	private var tasks: [Task] = []
	private var team: [UserHeader] = []
    private var currentStatus: Status? = nil
    private var currentPriority: Priority? = nil
    private var currentUserHeader: UserHeader? = nil
    private var menuOpen: Bool = false
    
    override func viewDidLoad() {
		super.viewDidLoad()
		
        updateFilterText()
        initMenuButtons()
		initTableView()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		updateTaskView()
	}
    
    private func updateTaskView() {
		Observable.zip(
			TL.taskLocoApi.filterTask(status: currentStatus, priority: currentPriority, username: currentUserHeader?.username)
				.mapToHandleResponse()
				.map({ $0.filter({ $0.status != .closed })}),
			TL.taskLocoApi.allUsers().mapToHandleResponse(), resultSelector: { return ($0, $1) })
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { result in
				self.tasks = result.0
				self.team = result.1
				self.teamTaskTableView.reloadData()
				self.updateFilterText()
				self.updateAnalyticsView()
			}, onError: { error in
				self.handleError(error)
			}).disposed(by: disposeBag)
    }
	
	private func initMenuButtons() {
		self.priorityMenuButton.isHidden = true
		self.statusMenuButton.isHidden = true
		self.userMenuButton.isHidden = true
		self.clearMenuButton.isHidden = true
	}
	
	private func initTableView() {
		teamTaskTableView.dataSource = self
        teamTaskTableView.delegate = self
	}
    
    private func updateFilterText() {
        priorityFilterText.text = currentPriority?.rawValue ?? General.all
        statusFilterText.isHidden = currentStatus == nil
        statusFilterText.text = currentStatus?.rawValue ?? General.all
        usernameFilterText.isHidden = currentUserHeader == nil
		usernameFilterText.text = currentUserHeader?.name ?? General.all
		priorityFilterText.isHidden = currentPriority == nil && (currentStatus != nil || currentUserHeader != nil)
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
		navigateToTaskAlertSheet(ViewController.createTask, self.tasks[indexPath.row])
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
            break;
        case 4:
            currentPriority = nil
            currentStatus = nil
            currentUserHeader = nil
            toggleFilterMenu()
			if(!menuOpen) { self.updateTaskView() }
            break;
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
            self.clearMenuButton.isHidden = !self.clearMenuButton.isHidden
			self.togglePanelMenu(hidePriority: true, hideStatus: true)
            self.menuOpen = !self.menuOpen
        })
    }
	
	private func togglePanelMenu(hidePriority: Bool, hideStatus: Bool) {
//		UIView.animate(withDuration: 0.5, animations: {
			self.priorityButtonsStack.isHidden = hidePriority
			self.statusButtonStack.isHidden = hideStatus
//		})
	}
    
    private func showUserPicker() {
		namesPicker = showPicker()
		namesPicker?.delegate = self
    }
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return team.count
	}

	func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return team[row].name + General.fourTab + team[row].username
	}

	func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		currentUserHeader = team[row]
	}
}
