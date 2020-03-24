//
//  AlertDialogViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/20/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class CreateTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
    @IBOutlet weak var headerBackground: UIView!
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
	private var namesPicker: UIPickerView? = nil
	private var allUsers: [UserHeader] = []
	private var currentStatus = Status.pending
	private var currentUserHeader = UserHeader()
	var currentTaskInfo: Task? = nil
	private var shouldClose = false
    
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
	}
	
	private func initButtonBackground() {
		pendingButton.backgroundColor = Status.pending.color
        inProgressButton.backgroundColor = Status.inProgress.color
        completedButton.backgroundColor = Status.completed.color
	}
	
	private func initPicker() {
		taskCompletedBy.showDatePicker()
		namesPicker = taskResponsible.showPicker()
		namesPicker?.dataSource = self
		namesPicker?.delegate = self
	}
	
	private func updateStatusView(_ status: Status) {
		currentStatus = status
        headerBackground.backgroundColor = currentStatus.color
        headerTitle.text = currentStatus.rawValue
		createButton.backgroundColor = currentStatus.color
    }
	
	private func updateFields() {
		taskTitle.text = currentTaskInfo?.title ?? General.empty
		taskDescription.text = currentTaskInfo?.description ?? General.empty
		taskCompletedBy.text = currentTaskInfo?.completeBy ?? General.empty
		taskResponsible.text = currentTaskInfo?.responsible.name ?? General.empty
        taskAssignee.text = currentTaskInfo?.assignee.name ?? TL.userManager.provideUserHeader().name
		createButton.setTitle(currentTaskInfo != nil ? ButtonConstants.update : ButtonConstants.create, for: .normal)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		updateHighPriority()
		TL.taskLocoApi.allUsers()
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { names in
				self.allUsers = names
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
	}
    
    @IBAction func highPriorityButtonAction(_ sender: Any) {
        if(isPulsing()) {
            highPriorityButton.backgroundColor = ColorConstants.lightGrey
            highPriorityButton.removePulse(headerBackground.layer)
        } else {
            highPriorityButton.backgroundColor = ColorConstants.lightRed
            highPriorityButton.pulse(headerBackground.layer)
        }
    }
	
	func updateHighPriority() {
		if(currentTaskInfo?.priority == .high) {
			highPriorityButton.backgroundColor = ColorConstants.lightRed
			highPriorityButton.pulse(headerBackground.layer)
		} else {
			highPriorityButton.backgroundColor = ColorConstants.lightGrey
			highPriorityButton.removePulse(headerBackground.layer)
		}
	}
	
	private func isPulsing() -> Bool {
		return highPriorityButton.isPulsing(headerBackground.layer)
	}
    
    @IBAction func pendingAction(_ sender: Any) {
		updateStatusView(.pending)
    }
    @IBAction func inProgressButtonAction(_ sender: Any) {
		updateStatusView(.inProgress)
    }
    @IBAction func completedButtonAction(_ sender: Any) {
		TL.userManager.isClosedEnabled()
			? self.shouldClose = true
			: confirmationAlert(archive: { (action) in self.shouldClose = true }) { (action) in self.shouldClose = false }
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
					title: taskTitle.text!,
					description: taskDescription.text!,
					completeBy: taskCompletedBy.text!,
					assignee: TL.userManager.provideUserHeader(),
					responsible: currentTaskInfo?.responsible ?? currentUserHeader,
					priority: isPulsing() ? Priority.high: Priority.standard,
					status: currentStatus,
					closed: currentStatus == .completed && shouldClose)
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return allUsers.count
	}

	func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return allUsers[row].name + General.fourTab + allUsers[row].username
	}

	func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		taskResponsible.text = allUsers[row].name
		currentUserHeader.username = allUsers[row].username
		currentUserHeader.name = allUsers[row].name
	}
}
