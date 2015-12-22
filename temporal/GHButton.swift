//
//  GHPlusButton.swift
//  temporal
//
//  Created by Graham Held on 10/2/15.
//  Copyright © 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

protocol GHButtonDelegate {
    func GHButtonPressed(button:GHButton, tapNum:UInt8)
}

class GHButton : GHView
{
    let backgroundShape = CAShapeLayer()
    let ringShape = CAShapeLayer()
    private var numTaps:UInt8 = 0
    private var timeout:Double = 0.4
    var maxTaps:UInt8 = 1
    private var clickTimer:NSTimer?
    var delegate:GHButtonDelegate?
    var fac:CGFloat = 0.0

    init(frame: CGRect, maxTaps:UInt8 = 1, timeout:Double = 0.4) {
        super.init(frame: frame)
        self.maxTaps = maxTaps
        self.timeout = timeout

        let circlePath = UIBezierPath(ovalInRect: frame.bounds)
        backgroundShape.path = circlePath.CGPath
        backgroundShape.fillColor = GHMasterControl.sharedInstance().theme.themeCol2.CGColor
        layer.addSublayer(backgroundShape)

        ringShape.path = circlePath.CGPath
        ringShape.strokeColor = GHMasterControl.sharedInstance().theme.themeCol3.CGColor
        ringShape.fillColor = UIColor.clearColor().CGColor
        ringShape.lineWidth = 1.0;
        backgroundShape.addSublayer(ringShape)

        let singleTap = UITapGestureRecognizer(target: self, action: "handleTap:")
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func handleTap(tap:UITapGestureRecognizer)
    {
        handleTapWithNumber(tap, numTaps:numTaps+1)
        if (maxTaps > 1)
        {
            numTaps++
            if(numTaps == 1){
                clickTimer?.invalidate()
                clickTimer = nil
                clickTimer = NSTimer.scheduledTimerWithTimeInterval(timeout, target: self, selector: Selector("resetNumTaps"), userInfo: nil, repeats: false)

            }
            if(numTaps == maxTaps){
                numTaps = 0
                clickTimer?.invalidate()
                clickTimer = nil

            }
        }

        displayState()
    }

    func handleTapWithNumber(tap:UITapGestureRecognizer, numTaps:UInt8)
    {
        delegate?.GHButtonPressed(self, tapNum: numTaps)
    }

    func resetNumTaps(){
        numTaps = 0
    }

    func displayState() {

    }
}