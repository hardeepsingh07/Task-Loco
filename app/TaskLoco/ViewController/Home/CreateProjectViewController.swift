//
//  CreateProject.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 5/3/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

class CreateProjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, OnSelectionDelegate {
	
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var projectId: UITextField!
    @IBOutlet weak var projectDescription: UITextField!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet weak var header: RandientView!
    @IBOutlet weak var buttonBackground: RandientView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    
	private let ADD_INDEX = 0
	var team: [UserHeader] = []
    
    override func viewDidLoad() {
		super.viewDidLoad()
		initView()
		initCollectionView()
	}
	
	private func initView() {
		let gradient = header.randomize(animated: true)
		self.buttonBackground.update(for: gradient, animated: true)
        self.buttonLabel.handleColor(gradient: gradient)
        self.projectLabel.handleColor(gradient: gradient)
		self.name.bottomBorder(uiColor: ColorConstants.lightGrey)
        self.projectId.bottomBorder(uiColor: ColorConstants.lightGrey)
        self.projectDescription.bottomBorder(uiColor: ColorConstants.lightGrey)
	}
	
    @IBAction func createProject(_ sender: Any) {
        
    }
    
    private func initCollectionView() {
		self.teamCollectionView.dataSource = self
		self.teamCollectionView.delegate = self
		let width = (view.frame.size.width - 42) / 2
		let layout = self.teamCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.team.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if(indexPath.row == ADD_INDEX) {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.add, for: indexPath) as! AddUserCell
			cell.updateCell()
			cell.applyBorder()
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.user, for: indexPath) as! UserCell
			cell.updateCell(self.team[indexPath.row - 1])
			cell.applyBorder()
			return cell
		}
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if(indexPath.row == ADD_INDEX) {
			self.navigateToUsersAlertSheet(.multiple, self, team)
		} else {
			self.removeAlert(team[indexPath.row - 1], remove: { (action) in
				self.team.remove(at: indexPath.row - 1)
			})
		}
	}
	
	func onSelected(selection: [UserHeader]) {
		self.team.append(contentsOf: selection)
	}
}
