//
//  CircularProgressView.swift
//  CircularProgressView
//
//  Created by Romain Bousquet on 30/01/2017.
//  Copyright © 2017 Romain Bousquet. All rights reserved.
//

import UIKit
import UICircularProgressRing

class CircularProgressView: UIView {

	var imageView: UIImageView
	
	var progressValue: Float = 0 {
		didSet {
			ringColoredView.value = CGFloat(self.progressValue)
			ringColoredView.fontColor = CircularProgressView.color(for: self.progressValue)
			ringColoredView.innerRingColor = CircularProgressView.color(for: self.progressValue)
		}
	}
	var valueFontSize: Float = 18 {
		didSet {
			ringColoredView.fontSize = CGFloat(self.valueFontSize)
		}
	}
	
	// MARK: Ring properties
	fileprivate var ringShadowView: UICircularProgressRingView
	fileprivate var ringColoredView: UICircularProgressRingView
	private static let startAngle: CGFloat = 45
	private static let endAngle: CGFloat = 270
	
	override init(frame: CGRect) {
		self.ringShadowView = UICircularProgressRingView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
		self.ringColoredView = UICircularProgressRingView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
		self.imageView = UIImageView(frame: CGRect(x: frame.size.width * 0.75, y: 0, width: frame.size.width / 4, height: frame.size.width / 4))
		super.init(frame: frame)
		self.imageView.contentMode = .scaleAspectFit
		initialize()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Setup
	private func initialize() {
		backgroundColor = .lightGray
		addSubview(ringShadowView)
		addSubview(ringColoredView)
		addSubview(imageView)

		setupShadowRing()
		setupColoredRing()
	}
	
	private func setupShadowRing() {
		ringShadowView.maxValue = 1
		ringShadowView.value = 1
		ringShadowView.startAngle = CircularProgressView.startAngle
		ringShadowView.endAngle = CircularProgressView.endAngle
		ringShadowView.outerRingWidth = 0
		ringShadowView.fontColor = .clear
		ringShadowView.innerRingColor = .lightGray
	}
	
	private func setupColoredRing() {
		ringColoredView.maxValue = 10
		ringColoredView.value = CGFloat(progressValue)
		ringColoredView.startAngle = CircularProgressView.startAngle
		ringColoredView.endAngle = CircularProgressView.endAngle
		ringColoredView.outerRingWidth = 0
		ringColoredView.fontColor = .clear
		ringColoredView.fontSize = CGFloat(valueFontSize)
		ringColoredView.innerRingColor = .red
		ringColoredView.showFloatingPoint = true
		ringColoredView.decimalPlaces = 1
	}
	
}

// MARK: Color handling
fileprivate extension CircularProgressView {
	
	fileprivate static func color(for value: Float) -> UIColor {
		switch value {
		case 0...3:
			return .red
		case 3...6:
			return .orange
		case 6...10:
			return .green
		default:
			return .clear
		}
	}
	
}
