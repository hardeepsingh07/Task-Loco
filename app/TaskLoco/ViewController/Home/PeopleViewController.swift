//
//  PeopleViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class PeopleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
	
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    @IBOutlet weak var peopleSearch: UISearchBar!
    
    private let disposeBag = DisposeBag()
    private var people: [UserHeader] = []
    private var filteredData: [UserHeader] = []
    
    override func viewDidLoad() {
		super.viewDidLoad()
        self.peopleSearch.delegate = self
        self.peopleCollectionView.dataSource = self
        self.peopleCollectionView.delegate = self
	}
    
    override func viewDidAppear(_ animated: Bool) {
        TL.taskLocoApi.allUsers()
			.mapToHandleResponse()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { users in
				self.people = users
                self.filteredData = self.people
				self.peopleCollectionView.reloadData()
            }, onError: { error in
                self.handleError(error)
            })
        .disposed(by: disposeBag)
    }
	
	private func initCollectionView() {
		self.peopleCollectionView.dataSource = self
		self.peopleCollectionView.delegate = self
		let width = view.frame.size.width / 2
		let layout = self.peopleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.people, for: indexPath) as! PeopleCell
        cell.updateCell(self.filteredData[indexPath.row])
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		navigateToTaskAlertSheet(ViewController.createTask, self.archiveTasks[indexPath.row])
	}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? people : people.filter { (item: UserHeader) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.peopleCollectionView.reloadData()
    }
}
