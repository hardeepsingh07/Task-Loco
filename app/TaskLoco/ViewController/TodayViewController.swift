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

enum TodayTile {
	case highPriority(_ tasks: [Task])
	case inProgress(_ tasks: [Task])
	case pending(_ tasks: [Task])
	case completed(_ tasks: [Task])
	
	var title: String {
		switch self {
		case .highPriority:
			return "High Priority"
		case .inProgress:
			return "In Progress"
		case .pending:
			return "Pending"
		case .completed:
			return "Completed"
		}
	}
	
	var color: UIColor {
		switch self {
		case .highPriority:
			return UIColor.red
		case .inProgress:
			return UIColor.yellow
		case .pending:
			return UIColor.blue
		case .completed:
			return UIColor.green
		}
	}
	
	var tasks: [Task] {
		switch self {
		case .highPriority(let tasks):
			return tasks.filter({ return $0.priority == Priority.high && $0.status != Status.completed });
		case .inProgress(let tasks):
			return tasks.filter({ return $0.priority != Priority.high && $0.status == Status.inProgress })
		case .pending(let tasks):
			return tasks.filter({ return $0.priority != Priority.high && $0.status == Status.pending })
		case .completed(let tasks):
			return tasks.filter({ return $0.status == Status.completed })
		}
	}
}

class TodayViewController: UIViewController, UITableViewDataSource {
	
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var todayTableView: UITableView!
    @IBOutlet weak var remainingText: UILabel!
    
	private let progressBar = UICircularProgressRing()
	private var completedTask: [Task] = []
	private var todayCollectionData: [TodayTile] = []
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		todayTableView.dataSource = self
		addProgressBar()
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
		let pending = TodayTile.pending(tasks)
		let completed = TodayTile.completed(tasks)
		remainingText.text = "\(pending.tasks.count) out of \(tasks.count) remaining"
		updateProgressBar(value: CGFloat(completed.tasks.count) / CGFloat(tasks.count))
		self.todayCollectionData = [TodayTile.highPriority(tasks), TodayTile.inProgress(tasks), pending, completed]
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
		progressBar.outerRingColor = UIColor.white
		progressBar.fontColor = UIColor.white
		progressBar.innerRingColor = ColorConstants.primaryColor
		progressBar.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(progressBar)
		
		view.addConstraints([addDirectionConstraint(progressBar, headerView, .bottom, -10),
							 addDirectionConstraint(progressBar, headerView, .right, -10),
							 addLayoutConstraint(progressBar, .width, 75),
							 addLayoutConstraint(progressBar, .height, 75)])
	}
	
	private func addDirectionConstraint(_ view: UIView, _ secondView: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: constrait, multiplier: 1, constant: constant)
	}
	
	private func addLayoutConstraint(_ view: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
	}
}

