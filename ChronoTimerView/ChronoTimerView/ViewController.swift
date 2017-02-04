//
//  ViewController.swift
//  ChronoTimerView
//
//  Created by Romain Bousquet on 03/02/2017.
//  Copyright © 2017 Romain Bousquet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		
		let chronoView = Bundle.main.loadNibNamed("ChronoTimerView", owner: self, options: nil)?.first as! ChronoTimerView
		view.addSubview(chronoView)
	}

}

