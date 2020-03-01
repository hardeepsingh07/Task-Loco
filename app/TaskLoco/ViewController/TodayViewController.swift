//
//  TodayViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import RxSwift

extension UIView {
    func fade() {
        let mask = CAGradientLayer()
		mask.startPoint = CGPoint(x: 1.0, y: 0.7)
		mask.endPoint = CGPoint(x: 0.0, y: 0.5)
        let whiteColor = UIColor.white
		mask.colors = [whiteColor.withAlphaComponent(0.0).cgColor,whiteColor.withAlphaComponent(1.0),whiteColor.withAlphaComponent(1.0).cgColor]
		mask.locations = [NSNumber(value: 0.0),NSNumber(value: 0.2),NSNumber(value: 1.0)]
        mask.frame = self.bounds
        self.layer.mask = mask
    }
}

class TodayViewController: UIViewController, UICollectionViewDataSource {
	
    @IBOutlet weak var highPriorityView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
	
	private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		highPriorityView.fade()
		collectionView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		TL.taskLocoApi.getTodayTasks(username: TL.authManager.provideUsername())
			.observeOn(MainScheduler.instance)   
			.mapToHandleResponse()
			.subscribe(onNext: { tasks in
				print(tasks)
			}, onError: { error in
				self.handleError(error)
			})
		.disposed(by: disposeBag)
	}
	
	private func handleResonse<T: Response>(_ response: T) throws -> T.CodableType {
		guard let data = response.data else { throw response.error ?? ErrorConstants.defaultError()}
		return data
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskPrototypeCell", for: indexPath)
		return cell
	}
}

