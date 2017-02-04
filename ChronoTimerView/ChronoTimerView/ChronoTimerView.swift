//
//  ChronoTimerView.swift
//  ChronoTimerView
//
//  Created by Romain Bousquet on 03/02/2017.
//  Copyright © 2017 Romain Bousquet. All rights reserved.
//

import UIKit

class ChronoTimerView: UIView {

	@IBOutlet weak var chronoView: UIView!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!

	fileprivate var dashedRingView: UICircularProgressRingView
	fileprivate var progressArcView: UICircularProgressRingView?
	
	// MARK: UI Consts
	static private let lineWidth: CGFloat = 2.5
	static private let dashPattern: [CGFloat] = [7.746, 2.582] //-- complete circle = 619.7 for 2.5 linewidth
	static private let arcSize: CGFloat = 4.5
    static private let marginBetweenDashes: CGFloat = 1.5
	
	// MARK: Colors
	static private let dashedCircleColor = UIColor(red: 67.0/255.0, green: 166.0/255.0, blue: 246.0/255.0, alpha: 1)
    static private let arcColor = UIColor(red: 247.0/255.0, green: 83.0/255.0, blue: 78.0/255.0, alpha: 1)
    
    // MARK: Timers
    private var secondHandTimer: Timer? //-- timer pour refresh l'ui du chronometre
    
    // MARK: Iterating properties
    private var currentProgressAngle: CGFloat = 0
    
    // MARK: Date handling
    private var startDate: Date?
    private let dateFormatter: DateFormatter

	// MARK: LifeCycle
	required init?(coder aDecoder: NSCoder) {
		self.dashedRingView = UICircularProgressRingView(frame: CGRect.zero)
        self.dateFormatter = DateFormatter()
		super.init(coder: aDecoder)
		initialize()
	}
    
    deinit {
        secondHandTimer?.invalidate()
    }

	private func initialize() {
		dashedRingView.innerRingWidth = 0
		dashedRingView.outerRingWidth = ChronoTimerView.lineWidth
		dashedRingView.viewStyle = 3
		dashedRingView.patternForDashes = ChronoTimerView.dashPattern
		dashedRingView.outerRingColor = ChronoTimerView.dashedCircleColor
		dashedRingView.fontColor = .clear
        
        dateFormatter.dateFormat = "H'h 'mm'm 'ss's'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
	}
    
    private func setupArc(with startAngle: CGFloat) {
        progressArcView = UICircularProgressRingView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        chronoView.addSubview(progressArcView!)
        
        progressArcView?.startAngle = startAngle
        progressArcView?.endAngle = startAngle + ChronoTimerView.arcSize
        progressArcView?.outerRingWidth = ChronoTimerView.lineWidth
        progressArcView?.innerRingWidth = 0
        progressArcView?.outerRingColor = ChronoTimerView.arcColor
        progressArcView?.maxValue = 100
        progressArcView?.fontColor = .clear
    }
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		chronoView.addSubview(dashedRingView)
		chronoView.backgroundColor = .clear
		dashedRingView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        timeLabel.text = "0h 00m 00s"
	}
    
    // MARK: Public fonction
    public func startChronometer() {
        startDate = Date()
        setupArc(with: currentProgressAngle)
        secondHandTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            guard let wSelf = self else { return }
            guard let startDate = wSelf.startDate else { return }
            
            //-- Label part
            let currentDate = Date()
            let timeInterval = currentDate.timeIntervalSince(startDate)
            let timerDate = Date(timeIntervalSince1970: timeInterval)
            wSelf.timeLabel.text = wSelf.dateFormatter.string(from: timerDate)
            
            //-- Second hand part
            if wSelf.progressArcView != nil {
                wSelf.progressArcView?.removeFromSuperview()
                wSelf.progressArcView = nil
            }
            wSelf.setupArc(with: wSelf.currentProgressAngle)
            wSelf.currentProgressAngle += ChronoTimerView.arcSize + ChronoTimerView.marginBetweenDashes
        })
    }
    
}
