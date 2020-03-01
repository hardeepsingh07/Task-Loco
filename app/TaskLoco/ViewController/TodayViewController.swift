//
//  TodayViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

extension UIView {
    func fade() {
        let mask = CAGradientLayer()
		mask.startPoint = CGPoint(x: 1.0, y: 0.7)
		mask.endPoint = CGPoint(x: 0.0, y: 0.5)
        let whiteColor = UIColor.white
		mask.colors = [whiteColor.withAlphaComponent(0.0).cgColor,whiteColor.withAlphaComponent(1.0),whiteColor.withAlphaComponent(1.0).cgColor]
		mask.locations = [NSNumber(value: 0.0),NSNumber(value: 0.2),NSNumber(value: 1.0)]
        mask.frame = self.bounds
        self.layer.mask = mask
    }
}

class TodayViewController: UIViewController, UICollectionViewDataSource {
	
    @IBOutlet weak var highPriorityView: UIView!
    @IBOutlet weak var inProgressView: UIView!
    @IBOutlet weak var pendingCompletedView: UIView!
    @IBOutlet weak var highPriorityCollectionView: UICollectionView!
    @IBOutlet weak var inProgressCollectionView: UICollectionView!
    @IBOutlet weak var pendingCompletedCollectionView: UICollectionView!
    
	private let disposeBag = DisposeBag()
	private var tasks: [Task] = []
    
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
				self.tasks = tasks
				self.highPriorityCollectionView.reloadData()
                self.inProgressCollectionView.reloadData()
                self.pendingCompletedCollectionView.reloadData()
			}, onError: { error in
				self.handleError(error)
			})
		.disposed(by: disposeBag)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return tasks.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.task, for: indexPath) as! TaskCell
		cell.update(task: tasks[indexPath.row])
		return cell
	}
}

