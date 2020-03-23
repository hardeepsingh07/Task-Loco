//
//  ArchieveViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/22/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class ArchiveViewController: UIViewController, UITableViewDataSource {
	
    @IBOutlet weak var archiveTableView: UITableView!
    private var archiveTasks: [Task] = []
	
	private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
		super.viewDidLoad()
        archiveTableView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.archiveTask()
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { archiveTasks  in
				self.archiveTasks = archiveTasks
				self.archiveTableView.reloadData()
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
	}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archiveTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.archive, for: indexPath) as! TaskCell
		cell.updateView(self.archiveTasks[indexPath.row], .archiveCell)
		return cell
    }
    
}
