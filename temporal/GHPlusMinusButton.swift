//
//  GHPlusMinusButton.swift
//  temporal
//
//  Created by Graham Held on 10/2/15.
//  Copyright © 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

class GHPlusMinusButton : GHButton
{

    var isPlus = true
    let vertShape:CAShapeLayer = CAShapeLayer()
    let horizShape:CAShapeLayer = CAShapeLayer()

    init(frame: CGRect, isPlus:Bool) {
        super.init(frame: frame)

        self.isPlus = isPlus

        let horizRect = CGRectMake(frame.bounds.width/5, frame.bounds.halfY - 1, frame.bounds.width*3/5, 2)
        let vertRect = CGRectMake(frame.bounds.halfX - 1, frame.bounds.height/5, 2, frame.bounds.height*3/5)

        let horizPath = UIBezierPath(rect: horizRect).CGPath
        let vertPath = UIBezierPath(rect: vertRect).CGPath

        horizShape.path = horizPath
        horizShape.fillColor = GHMasterControl.sharedInstance().theme.themeCol3.CGColor
        vertShape.path = vertPath
        vertShape.fillColor = GHMasterControl.sharedInstance().theme.themeCol3.CGColor

        backgroundShape.addSublayer(horizShape)
        if(self.isPlus)
        {
            backgroundShape.addSublayer(vertShape)
        }
    }

    override func handleTapWithNumber(tap: UITapGestureRecognizer, numTaps: UInt8) {
        super.handleTapWithNumber(tap, numTaps: numTaps)

        if(isPlus)
        {
            for node in GHMasterControl.sharedInstance().getSelection().getNodes()
            {
                node.addChildView(newTestSeqNode())
            }
        } else {
            for node in GHMasterControl.sharedInstance().getSelection().getNodes()
            {
                node.removeFromParent()
            }
        }
        
        let mn = GHMasterControl.sharedInstance().masterNode
        mn.layoutChildNodes()

        //GHMasterControl.sharedInstance().selectionChanged()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}