//
//  UsersViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class UsersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
	
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var selectionCollectionView: UICollectionView!
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIButton!
    
	private var filterData: [UserHeader] = []
	private var users: [UserHeader] = []
	private var selected: [UserHeader] = []
	private let disposeBag = DisposeBag()
	var userSelectionType = UsersSelectionType.single
	var onSelectionDelegate: OnSelectionDelegate? = nil
	var exclude = Set<UserHeader>()
    
    override func viewDidLoad() {
		super.viewDidLoad()
		initView()
	}
    
    override func viewDidAppear(_ animated: Bool) {
		let observer = userSelectionType == .single
			? TL.taskLocoApi.project(projectId: TL.userManager.provideProjectId())
				.mapToHandleResponse().map({ return $0[0].users })
			: TL.taskLocoApi.allUsers().mapToHandleResponse()
		
		observer
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: {users in
				self.users = self.userSelectionType == .multiple ? Array(Set(users).symmetricDifference(self.exclude)): users
				self.filterData = self.users
				self.userCollectionView.reloadData()
			}, onError: {error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
    }
	
    @IBAction func doneAction(_ sender: Any) {
		if(!selected.isEmpty) { onSelectionDelegate?.onSelected(selection: selected) }
        self.dismiss(animated: true)
    }
    
    private func initView() {
        searchBar.delegate = self
        pageTitle.text = userSelectionType.message
        initCollectionView()
    }
    
    private func initCollectionView() {
        self.selectionCollectionView.dataSource = self
        self.selectionCollectionView.delegate = self
		self.userCollectionView.dataSource = self
		self.userCollectionView.delegate = self
        
        //Double column
		let width = (view.frame.size.width - 42) / 2
		let layout = self.userCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: width, height: layout.itemSize.height)
	}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView {
		case selectionCollectionView:
			return self.selected.count
		default:
			return self.filterData.count
		}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.user, for: indexPath) as! UserCell
		
		switch collectionView {
		case selectionCollectionView:
			cell.updateCell(self.selected[indexPath.row])
		default:
			cell.updateCell(self.filterData[indexPath.row])
		}
		return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch collectionView {
		case selectionCollectionView:
			self.selected.remove(at: indexPath.row)
		default:
			let userHeader = filterData[indexPath.row]
			switch userSelectionType {
			case .single:
				selected.isEmpty ? selected.insert(userHeader, at: 0) : (selected[0] = userHeader)
			case .multiple:
				selected.insert(userHeader, at: 0)
			}
		}
		selectionCollectionView.reloadData()
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty ? users : users.filter { (item: UserHeader) -> Bool in
			return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        userCollectionView.reloadData()
    }
}
