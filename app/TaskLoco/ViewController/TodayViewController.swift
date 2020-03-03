//
//  TodayViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class TodayViewController: UIViewController, UICollectionViewDataSource {
	
    @IBOutlet weak var highPriorityView: UIView!
    @IBOutlet weak var inProgressView: UIView!
    @IBOutlet weak var pendingCompletedView: UIView!
	
    @IBOutlet weak var highPriorityCollectionView: UICollectionView!
    @IBOutlet weak var inProgressCollectionView: UICollectionView!
    @IBOutlet weak var pendingCompletedCollectionView: UICollectionView!
	
	private var allTask: [Task] = []
	private var highPriority: [Task] = []
	private var inProgress: [Task] = []
	private var pendingComplete: [Task] = []
	
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		highPriorityView.fade()
        inProgressView.fade()
        pendingCompletedView.fade()
		highPriorityCollectionView.dataSource = self
        inProgressCollectionView.dataSource = self
        pendingCompletedCollectionView.dataSource = self
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
		self.allTask = tasks
		self.highPriority = tasks.filter({ return $0.priority == Priority.high })
		self.inProgress = tasks.filter({ return $0.priority != Priority.high && $0.status == Status.inProgress })
		self.pendingComplete = tasks.filter({ return $0.priority != Priority.high && $0.status != Status.inProgress })
		self.highPriorityCollectionView.reloadData()
		self.inProgressCollectionView.reloadData()
		self.pendingCompletedCollectionView.reloadData()
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView {
		case self.highPriorityCollectionView:
			return highPriority.count
		case self.inProgressCollectionView:
			return inProgress.count
		case self.pendingCompletedCollectionView:
			return pendingComplete.count
		default:
			return allTask.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.task, for: indexPath) as! TaskCell
		switch collectionView {
		case self.highPriorityCollectionView:
			cell.update(task: highPriority[indexPath.row])
		case self.inProgressCollectionView:
			cell.update(task: inProgress[indexPath.row])
		case self.pendingCompletedCollectionView:
			cell.update(task: pendingComplete[indexPath.row])
		default:
			cell.update(task: allTask[indexPath.row])
		}
		return cell
	}
}

