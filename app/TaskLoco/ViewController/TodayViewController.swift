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
			return tasks.filter({ return $0.priority == Priority.high });
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
		updateProgressBar(value: CGFloat(TodayTile.completed(tasks).tasks.count) / CGFloat(tasks.count))
		self.todayCollectionData = [TodayTile.highPriority(tasks), TodayTile.inProgress(tasks), TodayTile.inProgress(tasks), TodayTile.pending(tasks)]
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
		progressBar.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(progressBar)
		
		view.addConstraints([addDirectionConstraint(progressBar, headerView, .bottom, -20),
							 addDirectionConstraint(progressBar, headerView, .right, -20),
							 addLayoutConstraint(progressBar, .width, 100),
							 addLayoutConstraint(progressBar, .height, 100)])
	}
	
	private func addDirectionConstraint(_ view: UIView, _ secondView: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: constrait, multiplier: 1, constant: constant)
	}
	
	private func addLayoutConstraint(_ view: UIView, _ constrait: NSLayoutConstraint.Attribute, _ constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: constrait, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
	}
}

