//
//  ViewController.swift
//  CircularProgressView
//
//  Created by Romain Bousquet on 29/01/2017.
//  Copyright © 2017 Romain Bousquet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		let circularView = CircularProgressView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
		circularView.progressValue = 10
		circularView.valueFontSize = 25
		circularView.imageView.image = UIImage(named: "5096775680_7c0a985c00_b.jpg")!
		view.addSubview(circularView)
	}

}

