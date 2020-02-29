//
//  TodayViewController.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/27/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit

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
	
	let authManager = AuthManager()
	
    @IBOutlet weak var highPriorityView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		highPriorityView.fade()
		collectionView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		messageAlert("Stored Data", "\(authManager.provideUsername()):\(authManager.provideApiKey())")
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskPrototypeCell", for: indexPath)
		return cell
	}
}

