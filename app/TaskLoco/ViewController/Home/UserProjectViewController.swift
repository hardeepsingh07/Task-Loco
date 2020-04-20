//
//  UserProjectViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/19/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class UserProjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var projectCollectionView: UICollectionView!
    
	var selectedUsername: String? = nil
    private let disposeBag = DisposeBag()
    private var project: [Project] = []
    
    override func viewDidLoad() {
		super.viewDidLoad()
        initCollectionView()
	}
    
    override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.updateWithProject(username: selectedUsername ?? General.empty)
			.mapToHandleResponse()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { userProject in
                self.name.text = userProject.user.name
                self.username.text = userProject.user.username
				self.email.text = userProject.user.email
				self.project = userProject.project
				self.projectCollectionView.reloadData()
            }, onError: { error in
                self.handleError(error)
            })
        .disposed(by: disposeBag)
    }
	
	private func initCollectionView() {
		self.projectCollectionView.dataSource = self
		let width = (view.frame.size.width / 2) - 25
		let layout = self.projectCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.project.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.userProject, for: indexPath) as! UserProjectCell
        cell.updateCell(self.project[indexPath.row])
		cell.applyBorder()
        return cell
    }
}
