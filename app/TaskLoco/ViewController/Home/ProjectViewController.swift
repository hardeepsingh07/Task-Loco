//
//  ProjectViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 4/4/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

class ProjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var projectCollectionView: UICollectionView!
	
	private var projects: [Project] = []
	private let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
		super.viewDidLoad()
		greeting.text = Greeting.message
		projectCollectionView.dataSource = self
		projectCollectionView.delegate = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.userProjects(username: TL.userManager.provideUserHeader().username)
			.observeOn(MainScheduler.instance)
			.mapToHandleResponse()
			.subscribe(onNext: { projects in
				self.projects = projects
				self.projects.sort { $0.starred && !$1.starred }
				self.projectCollectionView.reloadData()
			}, onError: { error in
				self.handleError(error)
			})
		.disposed(by: disposeBag)
	}
    
    @IBAction func userIconClick(_ sender: Any) {
		self.navigateToUseAlertSheet()
    }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstants.project, for: indexPath) as! ProjectCell
        cell.updateCell(self.projects[indexPath.row])
        return cell
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath) as! ProjectCell
		TL.userManager.projectGradient = cell.gradientBackground.gradient
		TL.userManager.updateProjectId(projectId: projects[indexPath.row].projectId)
		TL.userManager.updateAutoCloseSetting(enabled: projects[indexPath.row].autoClose)
		self.navigateTo(UITabBarController.self, ViewController.projectTabBar, false)
	}
}
