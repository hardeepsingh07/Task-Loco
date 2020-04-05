//
//  UsersViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class UsersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIButton!
    
    private var users: [UserHeader] = []
	private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
		super.viewDidLoad()
        initCollectionView()
	}
    
    override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.allUsers()
			.mapToHandleResponse()
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: {users in
				self.users = users
				self.userCollectionView.reloadData()
			}, onError: {error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
    }
	
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func initCollectionView() {
		self.userCollectionView.dataSource = self
		self.userCollectionView.delegate = self
		let width = (view.frame.size.width - 42) / 2
		let layout = self.userCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.user, for: indexPath) as! UserCell
		cell.updateCell(self.users[indexPath.row])
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}
