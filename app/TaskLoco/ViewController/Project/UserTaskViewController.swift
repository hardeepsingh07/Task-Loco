//
//  TodayViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift
import UICircularProgressRing

class UserTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var todayTableView: UITableView!
    @IBOutlet weak var remainingText: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
	private var progressBar: UICircularProgressRing?
	private var todayData: [Task] = []
	
	private let disposeBag = DisposeBag()
	private var alertController: UIAlertController? = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
		todayTableView.dataSource = self
		todayTableView.delegate = self
		initHeaderView()
	}
	
	private func initHeaderView() {
		self.headerTitle.primaryColor()
		self.remainingText.secondaryColor()
		self.progressBar = addProgressBar(seperatorView)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.userTask(projectId: TL.userManager.provideProjectId(), username: TL.userManager.provideUserHeader().username)
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { tasks in
				self.handleResponse(tasks: tasks)
			}, onError: { error in
				self.handleError(error)
			})
		.disposed(by: disposeBag)
	}

    private func handleResponse(tasks: [Task]) {
		let completed = tasks.filter { $0.status == .completed }
		remainingText.text = "\(tasks.count - completed.count) out of \(tasks.count) remaining"
		if(tasks.count != 0) {
			updateProgressBar(value: CGFloat(completed.count) / CGFloat(tasks.count))
		}
		self.todayData = tasks
		self.todayTableView.reloadData()
	}
	
	private func updateProgressBar(value: CGFloat) {
		progressBar?.startProgress(to: (value*100), duration: 2.0)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.todayData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.task, for: indexPath) as! TaskCell
		cell.updateCell(self.todayData[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		navigateToTaskAlertSheet(ViewController.createTask, self.todayData[indexPath.row])
	}
}
