//
//  SettingsViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class SettingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, OnSelectionDelegate {
	
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectId: UITextField!
    @IBOutlet weak var closedSwitch: UISwitch!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
	private let ADD_INDEX = 0
	private var teamMembers: [UserHeader] = []
	private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
		super.viewDidLoad()
        closedSwitch.isOn = TL.userManager.shouldAutoClose()
		initCollectionView()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.project(projectId: TL.userManager.provideProjectId())
			.mapToHandleResponse()
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { project in
				self.handleProjectData(project)
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
	}
	
	private func addRemoveMember(add: Bool, userHeader: UserHeader) {
		let observer = add
			? TL.taskLocoApi.addMember(projectId: TL.userManager.provideProjectId(), userHeader: userHeader)
			: TL.taskLocoApi.removeMember(projectId: TL.userManager.provideProjectId(), userHeader: userHeader)
		
		observer
			.mapToHandleResponse()
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { project in
				self.handleProjectData(project)
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
	}
	
	private func handleProjectData(_ data: [Project]) {
		let project = data[0]
		self.projectId.text = project.projectId
		self.projectName.text = project.name
		self.teamMembers = project.users
		self.teamCollectionView.reloadData()
	}
    
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
		TL.taskLocoApi.updateProject(projectId: TL.userManager.provideProjectId(), autoClose: sender.isOn)
			.mapToHandleResponse()
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: {project in
				TL.userManager.updateAutoCloseSetting(enabled: project[0].autoClose)
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
    }
	
    @IBAction func onImageViewClicked(_ sender: Any) {
		self.dismiss(animated: true)
    }
	
	private func initCollectionView() {
		self.teamCollectionView.dataSource = self
		self.teamCollectionView.delegate = self
		let width = (view.frame.size.width - 42) / 2
		let layout = self.teamCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.teamMembers.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		var cell: UserCell
		if(indexPath.row == ADD_INDEX) {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.add, for: indexPath) as! UserCell
		} else {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.user, for: indexPath) as! UserCell
			cell.updateCell(self.teamMembers[indexPath.row - 1])
		}
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if(indexPath.row == ADD_INDEX) {
			self.navigateToUsersAlertSheet(ViewController.users, .multiple, self)
		} else {
			self.removeAlert(teamMembers[indexPath.row - 1], remove: { (action) in
				self.addRemoveMember(add: false, userHeader: self.teamMembers[indexPath.row - 1])
			})
		}
	}
	
	func onSelected(selection: [UserHeader]) {
		selection.forEach { (userHeader) in
			self.addRemoveMember(add: true, userHeader: userHeader)
		}
	}
}
