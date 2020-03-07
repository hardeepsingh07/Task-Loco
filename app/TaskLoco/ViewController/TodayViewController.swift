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

struct TodayData {
	var headerTitle: String
	var headerColor: UIColor
	var tasks: [Task]
}

enum HeaderConstants {
	static var highPriority = "High Priority"
	static var inProgress = "In Progress"
	static var pending = "Pending"
	static var completed = "Completed"
}

class TodayViewController: UIViewController, UITableViewDataSource {
	
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var todayTableView: UITableView!
    
	private let progressBar = UICircularProgressRing()
	private var completedTask: [Task] = []
	private var todayCollectionData: [TodayData] = []
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		todayTableView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.getTodayTasks(username: TL.authManager.provideUsername())
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
		self.completedTask = tasks.filter({ return $0.status == Status.completed })
		updateProgressBar(value: CGFloat(completedTask.count) / CGFloat(tasks.count))
		
		let highPriority = TodayData(headerTitle: HeaderConstants.highPriority, headerColor: UIColor.red, tasks: tasks.filter({ return $0.priority == Priority.high }))
		let inProgress = TodayData(headerTitle: HeaderConstants.inProgress, headerColor: UIColor.yellow, tasks: tasks.filter({ return $0.priority != Priority.high && $0.status == Status.inProgress }))
		let pending = TodayData(headerTitle: HeaderConstants.pending, headerColor: UIColor.blue, tasks: tasks.filter({ return $0.priority != Priority.high && $0.status == Status.pending }))
		let completed = TodayData(headerTitle: HeaderConstants.completed, headerColor: UIColor.green, tasks: self.completedTask)
		
		self.todayCollectionData = [highPriority, inProgress, pending, completed]
		self.todayTableView.reloadData()
	}
	
	private func updateProgressBar(value: CGFloat) {
		progressBar.startProgress(to: (value*100), duration: 2.0)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.todayCollectionData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.today, for: indexPath) as! HeaderContainerCell
		cell.update(self.todayCollectionData[indexPath.row])
		return cell
	}

	private func addProgressBar() {
		progressBar.maxValue = 100
		progressBar.style = .ontop
		progressBar.outerRingColor = UIColor.lightGray
		progressBar.fontColor = UIColor.white
		progressBar.innerRingColor = UIColor.white
		view.addSubview(progressBar)
		progressBar.translatesAutoresizingMaskIntoConstraints = false
		let topConstraint = NSLayoutConstraint(item: progressBar, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: headerView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -20)
		let endConstraint = NSLayoutConstraint(item: progressBar, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: headerView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -20)
		let widthConstraint = NSLayoutConstraint(item: progressBar, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
		let heightConstraint = NSLayoutConstraint(item: progressBar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
		view.addConstraints([topConstraint, endConstraint, widthConstraint, heightConstraint])
	}
}

