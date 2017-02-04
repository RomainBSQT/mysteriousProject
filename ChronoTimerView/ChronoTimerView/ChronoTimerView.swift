//
//  ChronoTimerView.swift
//  ChronoTimerView
//
//  Created by Romain Bousquet on 03/02/2017.
//  Copyright © 2017 Romain Bousquet. All rights reserved.
//

import UIKit
import UICircularProgressRing

class ChronoTimerView: UIView {

	@IBOutlet weak var chronoView: UIView!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!

	fileprivate var dashedRingView: UICircularProgressRingView
	fileprivate var progressArcView: UICircularProgressRingView
	
	// MARK: UI Consts
	static private let lineWidth: CGFloat = 2.5
	static private let dashPattern: [CGFloat] = [8, 2.3]
	static private let arcSize: CGFloat = 6
	
	// MARK: Colors
	static private let dashedCircleColor = UIColor(red: 67.0/255.0, green: 166.0/255.0, blue: 246.0/255.0, alpha: 1)

	// MARK: Setup
	required init?(coder aDecoder: NSCoder) {
		self.dashedRingView = UICircularProgressRingView(frame: CGRect.zero)
		self.progressArcView = UICircularProgressRingView(frame: CGRect.zero)
		super.init(coder: aDecoder)
		initialize()
	}

	private func initialize() {
		dashedRingView.innerRingWidth = 0
		dashedRingView.outerRingWidth = ChronoTimerView.lineWidth
		dashedRingView.viewStyle = 3
		dashedRingView.patternForDashes = ChronoTimerView.dashPattern
		dashedRingView.outerRingColor = ChronoTimerView.dashedCircleColor
		dashedRingView.fontColor = .clear
		
		progressArcView.innerRingWidth = 0
		progressArcView.startAngle = 0
		progressArcView.outerRingWidth = ChronoTimerView.lineWidth
		progressArcView.patternForDashes = ChronoTimerView.dashPattern
		progressArcView.outerRingColor = .red
		progressArcView.fontColor = .clear
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		chronoView.addSubview(dashedRingView)
		chronoView.addSubview(progressArcView)
		chronoView.backgroundColor = .clear
		
		dashedRingView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
		progressArcView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
		
		animateArc(with: 100)
	}

	// MARK: Animation
	private func animateArc(with startAngle: CGFloat) {
		progressArcView.startAngle = startAngle
		progressArcView.endAngle = startAngle + ChronoTimerView.arcSize
	}
}
