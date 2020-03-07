//
//  TodayCell.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class HeaderContainerCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var taskCollectionView: UICollectionView!
    @IBOutlet weak var noTasksNote: UILabel!
    
	private var taskData: [Task] = []
    
    required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
    
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	func update(_ todayCollectionData: TodayData) {
		headerBackground.backgroundColor = todayCollectionData.headerColor
		headerBackground.fade()
		headerTitle.text = todayCollectionData.headerTitle
		taskData = todayCollectionData.tasks
		if(!taskData.isEmpty) {
			taskCollectionView.dataSource = self
			taskCollectionView.reloadData()
		} else {
			taskCollectionView.isHidden = true
			noTasksNote.isHidden = false
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return taskData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.task, for: indexPath) as! TaskCell
		cell.update(task: taskData[indexPath.row])
		cell.cellBorder()
		return cell
	}
}
