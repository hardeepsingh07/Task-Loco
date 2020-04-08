//
//  ArchieveViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/22/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class ArchiveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
    @IBOutlet weak var headerView: RandientView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var archiveCollectionView: UICollectionView!
    private var archiveTasks: [Task] = []
	
	private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
		super.viewDidLoad()
        initCollectionView()
        initHeaderView()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.filterTask(status: Status.closed, priority: nil, username: nil)
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { archiveTasks  in
				self.archiveTasks = archiveTasks
				self.archiveCollectionView.reloadData()
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
	}
	
    private func initHeaderView() {
        let gradient = TL.userManager.projectGradient
        headerView.update(for: (gradient ?? Randient.randomize()), animated: true)
        headerTitle.handleColor(gradient: gradient)
    }
    
	private func initCollectionView() {
		archiveCollectionView.dataSource = self
		archiveCollectionView.delegate = self
		let width = (view.frame.size.width - 30) / 2
		let layout = archiveCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return archiveTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.archive, for: indexPath) as! ArchiveCell
        cell.updateCell(self.archiveTasks[indexPath.row])
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		navigateToTaskAlertSheet(ViewController.createTask, self.archiveTasks[indexPath.row])
	}
}
