//
//  UsersViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

enum UsersSelectionType {
	case single
	case multiple
	
	var message: String {
		switch self {
		case .single:
			return "Select a User"
		case .multiple:
			return "Add Users"
		}
	}
}

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
    
    override func viewDidLoad() {
		super.viewDidLoad()
		initView()
	}
    
    override func viewDidAppear(_ animated: Bool) {
		let observer = userSelectionType == .single
			? TL.taskLocoApi.project(projectId: TL.userManager.provideProjectId()).mapToHandleResponse().map({ return $0[0].users })
			: TL.taskLocoApi.allUsers().mapToHandleResponse()
		
		observer
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: {users in
				self.users = users
				self.filterData = users
				self.userCollectionView.reloadData()
			}, onError: {error in
				self.handleError(error)
			})
			.disposed(by: disposeBag)
    }
	
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func initView() {
        searchBar.delegate = self
        pageTitle.text = userSelectionType.message
        doneButton.isHidden = userSelectionType == .single
        selectionView.isHidden = userSelectionType == .single
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
			selected.insert(filterData[indexPath.row], at: 0)
			if(userSelectionType == .single) {
				onSelectionDelegate?.onSelected(selection: selected)
				self.dismiss(animated: true)
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
