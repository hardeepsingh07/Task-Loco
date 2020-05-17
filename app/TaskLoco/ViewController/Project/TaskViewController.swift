//
//  AlertDialogViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/20/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class TaskViewController: UIViewController, OnSelectionDelegate, UITextFieldDelegate {
	
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var inProgressButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskAssignee: UITextField!
    @IBOutlet weak var taskResponsible: UITextField!
    @IBOutlet weak var taskCompletedBy: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var createButton: UIButton!
	
	private let disposeBag = DisposeBag()
	private var teamMembers: [UserHeader] = []
	private var currentStatus = Status.pending
	private var currentUserHeader = UserHeader()
	var currentTaskInfo: Task? = nil
    
    override func viewDidLoad() {
		super.viewDidLoad()
		setupBorder()
		initPicker()
		initButtonBackground()
		updateStatusView(currentTaskInfo?.status ?? currentStatus)
		updateFields()
	}
	
	private func setupBorder() {
		taskTitle.bottomBorder(uiColor: UIColor.lightGray)
		taskResponsible.bottomBorder(uiColor: UIColor.lightGray)
		taskCompletedBy.bottomBorder(uiColor: UIColor.lightGray)
		taskDescription.bottomBorder(uiColor: UIColor.lightGray)
		taskAssignee.bottomBorder(uiColor: UIColor.lightGray)
		taskResponsible.delegate = self
	}
	
	private func initButtonBackground() {
		pendingButton.backgroundColor = Status.pending.color
        inProgressButton.backgroundColor = Status.inProgress.color
        completedButton.backgroundColor = Status.completed.color
	}
	
	private func initPicker() {
		taskCompletedBy.showDatePicker()
	}
	
	private func updateStatusView(_ status: Status) {
		currentStatus = status
        headerTitle.text = currentStatus.rawValue
		createButton.backgroundColor = currentStatus.color
    }
	
	private func updateFields() {
		taskTitle.text = currentTaskInfo?.title ?? General.empty
		taskDescription.text = currentTaskInfo?.description ?? General.empty
		taskCompletedBy.text = currentTaskInfo?.completeBy ?? General.empty
		taskResponsible.text = currentTaskInfo?.responsible.name ?? General.empty
        taskAssignee.text = currentTaskInfo?.assignee.name ?? TL.userManager.provideUserHeader().name
		currentTaskInfo?.status == .closed
			? createButton.setTitle(ButtonConstants.reassign, for: .normal)
			: createButton.setTitle(currentTaskInfo != nil ? ButtonConstants.update : ButtonConstants.create, for: .normal)
		self.navigateToUsersAlertSheet(.single, self)

	}
	
	override func viewDidAppear(_ animated: Bool) {
		updateHighPriority()
		TL.taskLocoApi.project(projectId: TL.userManager.provideProjectId())
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { project in
				self.teamMembers = project[0].users
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
	}
    
    @IBAction func highPriorityButtonAction(_ sender: Any) {
        if(isPulsing()) {
            highPriorityButton.backgroundColor = ColorConstants.lightGrey
            highPriorityButton.removePulse(view.layer)
        } else {
            highPriorityButton.backgroundColor = ColorConstants.lightRed
            highPriorityButton.pulse(view.layer)
        }
    }
	
	func updateHighPriority() {
		if(currentTaskInfo?.priority == .high) {
			highPriorityButton.backgroundColor = ColorConstants.lightRed
			highPriorityButton.pulse(view.layer)
		} else {
			highPriorityButton.backgroundColor = ColorConstants.lightGrey
			highPriorityButton.removePulse(view.layer)
		}
	}
	
	private func isPulsing() -> Bool {
		return highPriorityButton.isPulsing(view.layer)
	}
    
    @IBAction func pendingAction(_ sender: Any) {
		updateStatusView(.pending)
    }
	
    @IBAction func inProgressButtonAction(_ sender: Any) {
		updateStatusView(.inProgress)
    }
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
        self.navigateToUsersAlertSheet(.single, self)
    }
	
    @IBAction func completedButtonAction(_ sender: Any) {
		TL.userManager.shouldAutoClose()
			? currentStatus = Status.closed
			: confirmationAlert(archive: { (action) in self.currentStatus = Status.closed }) { (action) in self.currentStatus = Status.closed }
		updateStatusView(.completed)
    }
	
    @IBAction func createButtonAction(_ sender: Any) {
		if (validateInput(textFields: taskTitle, taskDescription, taskCompletedBy, taskResponsible)) {
			let observer = currentTaskInfo == nil
				? TL.taskLocoApi.createTask(task: generateTask())
				: TL.taskLocoApi.updateTask(task: generateTask())
			
			observer
				.observeOn(MainScheduler.instance)
				.subscribe(onNext: { task in
					self.dismiss(animated: true, completion: nil)
				}, onError: { error in
					self.handleError(error)
					self.dismiss(animated: true, completion: nil)
				})
				.disposed(by: disposeBag)
		}
    }
	
	private func generateTask() -> Task {
		return Task(id: currentTaskInfo?.id,
					projectId: TL.userManager.provideProjectId(),
					title: taskTitle.text!,
					description: taskDescription.text!,
					completeBy: taskCompletedBy.text!,
					assignee: TL.userManager.provideUserHeader(),
					responsible: currentTaskInfo?.responsible ?? currentUserHeader,
					priority: isPulsing() ? Priority.high: Priority.standard,
					status: currentStatus)
	}
	
	func onSelected(selection: [UserHeader]) {
		let userHeader = selection[0]
		taskResponsible.text = userHeader.name
		currentUserHeader.username = userHeader.username
		currentUserHeader.name = userHeader.name
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return teamMembers.count
	}

	func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return teamMembers[row].name + General.fourTab + teamMembers[row].username
	}
}
