//
//  GHPlayButton.swift
//  temporal
//
//  Created by Graham Held on 9/17/15.
//  Copyright © 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

enum PlayState {
    case Stopped
    case Playing
    case Paused
}

class GHPlayButton: GHButton {

    var state:PlayState = .Stopped
    let stopShape = CAShapeLayer()
    let pauseShape = CAShapeLayer()
    let playShape = CAShapeLayer()

    init(frame: CGRect) {
        super.init(frame: frame, maxTaps:1)

        ringShape.strokeColor = UIColor.MolestyRed().CGColor

        let margin = GHMasterControl.sharedInstance().getMargin()
        let innerRect = CGRectMake(margin.X, margin.Y, frame.width - margin.X - margin.X, frame.height - margin.Y - margin.Y)

        let pauseLeftRect = CGRectMake(innerRect.width/5.0 + margin.X, innerRect.height/5.0 + margin.X, innerRect.width/5.0, innerRect.height/5.0 * 3.0)
        let pauseRightRect = CGRectMake(innerRect.width/5.0 * 3.0 + margin.Y, innerRect.height/5.0 + margin.Y, innerRect.width/5.0, innerRect.height/5.0 * 3.0)

        let pauseLeftPath = UIBezierPath(rect: pauseLeftRect)
        let pauseRightPath = UIBezierPath(rect: pauseRightRect)
        pauseLeftPath.appendPath(pauseRightPath)

        pauseShape.path = pauseLeftPath.CGPath
        pauseShape.fillColor = UIColor.CrispColor().CGColor
        pauseShape.strokeColor = UIColor.clearColor().CGColor
        pauseShape.opacity = 0.0

        let triWidth:CGFloat = sqrt(3.0)/2.0 * (innerRect.width/5.0 * 3.0)

        let playPath = UIBezierPath()
        playPath.moveToPoint(CGPointMake(innerRect.width/1.8 - triWidth/2.0 + margin.X, innerRect.height/5.0 + margin.Y))
        playPath.addLineToPoint(CGPointMake(innerRect.width/1.8 - triWidth/2.0 + margin.X, innerRect.height/5.0 * 4.0 + margin.Y))
        playPath.addLineToPoint(CGPointMake(innerRect.width/1.8 + triWidth/2.0 + margin.X, innerRect.height/2.0 + margin.Y))
        playPath.closePath()

        playShape.path = playPath.CGPath
        playShape.fillColor = UIColor.SnapGreen().CGColor
        playShape.strokeColor = UIColor.clearColor().CGColor
        playShape.opacity = 0.0

        let stopPath =  UIBezierPath(rect: CGRectMake(margin.X + innerRect.width/5.0, margin.Y + innerRect.height/5.0, innerRect.width/5.0 * 3.0, innerRect.height/5.0 * 3.0))

        stopShape.path = stopPath.CGPath
        stopShape.strokeColor = UIColor.clearColor().CGColor
        stopShape.fillColor = UIColor.MolestyRed().CGColor
        stopShape.opacity = 1.0

        backgroundShape.addSublayer(pauseShape)
        backgroundShape.addSublayer(playShape)
        backgroundShape.addSublayer(stopShape)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func handleTapWithNumber(tap: UITapGestureRecognizer, numTaps:UInt8) {
        super.handleTapWithNumber(tap, numTaps: numTaps)
        if(numTaps == 1)
        {
            if (state == .Stopped) {
                state = .Playing
                GHMasterControl.sharedInstance().playFirst()
            } else if  (state == .Paused){
                state = .Playing
                GHMasterControl.sharedInstance().playFirst()
            } else
                if (state == .Playing){
                    state = .Stopped
                    GHMasterControl.sharedInstance().stop()
            }
        }
        if(numTaps == 2)
        {
            state = .Stopped
            GHMasterControl.sharedInstance().stop()
        }
    }

    override func displayState() {
        if (state == .Stopped) {
            pauseShape.opacity = 0.0
            playShape.opacity = 0.0
            stopShape.opacity = 1.0
            ringShape.strokeColor = UIColor.MolestyRed().CGColor
        }
        if (state == .Playing) {
            pauseShape.opacity = 0.0
            playShape.opacity = 1.0
            stopShape.opacity = 0.0
            ringShape.strokeColor = UIColor.SnapGreen().CGColor
        }
        if (state == .Paused) {
            pauseShape.opacity = 1.0
            playShape.opacity = 0.0
            stopShape.opacity = 0.0
            ringShape.strokeColor = UIColor.CrispColor().CGColor
        }
    }
}