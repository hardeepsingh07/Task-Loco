//
//  SettingsViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class SettingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var closedSwitch: UISwitch!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
	private var teamMembers: [UserHeader] = []
	private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
		super.viewDidLoad()
		let userHeader = TL.userManager.provideUserHeader()
		name.text = userHeader.name
		username.text = userHeader.username
        closedSwitch.isOn = TL.userManager.isClosedEnabled()
		initCollectionView()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.allUsers()
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { users in
				self.teamMembers = users
				self.teamCollectionView.reloadData()
			}, onError: { error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
	}
    
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
		TL.userManager.updateClosedSetting(enabled: sender.isOn)
    }
	
    @IBAction func onImageViewClicked(_ sender: Any) {
        navigateTo(LoginViewController.self, ViewController.login, true)
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
		if(indexPath.row == 0) {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.add, for: indexPath) as! UserCell
		} else {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.user, for: indexPath) as! UserCell
			cell.updateCell(self.teamMembers[indexPath.row - 1])
		}
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath.row)
	}
}
