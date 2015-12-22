//
//  GHNodeTools.swift
//  temporal
//
//  Created by Graham Held on 9/19/15.
//  Copyright © 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

class GHNodeTools:GHView {

    var nodeRefs:[GHSequenceNode] = []
    var raised = false
    let gradLayer:CAGradientLayer = CAGradientLayer();
    var fac:CGFloat = 0.0
    var contentView:GHView!
    var animTimer:NSTimer!
    var minusButton:GHButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = GHMasterControl.sharedInstance().theme.themeCol1
        let margin = GHMasterControl.sharedInstance().getMargin()

        animTimer = NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: "update", userInfo: nil, repeats: true)

        contentView = GHView(frame: frame.bounds.offsetBy(dx: 0, dy: frame.height))
        contentView.backgroundColor = UIColor.clearColor()
        addChildView(contentView)

        backgroundColor = UIColor.clearColor()
        gradLayer.frame = CGRectMake(0, frame.size.height-32, frame.width, 32)
        gradLayer.colors = [UIColor.blackColor().colorWithAlphaComponent(0.4).CGColor,UIColor.blackColor().colorWithAlphaComponent(0.0).CGColor]
        gradLayer.startPoint = CGPointMake(0, 1)
        gradLayer.endPoint = CGPointMake(0, 0)
        gradLayer.zPosition = -100
        contentView.layer.addSublayer(gradLayer)

        let plusButton = GHPlusMinusButton(frame: CGRectMake(128 + margin.X, frame.height - 128 + margin.Y, 128 - margin.X - margin.X, 128 - margin.Y - margin.Y), isPlus: true)
        contentView.addChildView(plusButton)

        minusButton = GHPlusMinusButton(frame: CGRectMake(plusButton.frame.origin.x + plusButton.frame.width + margin.X, frame.height - 64 + margin.Y, 64 - margin.X * 2, 64 - margin.Y * 2), isPlus: false)
        contentView.addChildView(minusButton)
    }

    deinit
    {
        animTimer.invalidate()
        animTimer = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func raiseView(raised:Bool){
        self.raised = raised
    }

    func update() {
        fac += (raised.cg - fac) * 0.09
        let fac2 = pow(fac, 0.5)
        contentView.frame.origin = CGPointMake(0, ((1.0 - fac) * contentView.frame.height))
        gradLayer.frame.origin = CGPointMake(0, contentView.frame.height - (fac2 * gradLayer.frame.height))
    }

    override func selectionChanged() {
        nodeRefs = GHMasterControl.sharedInstance().getSelection().getNodes()
        minusButton.alpha = GHMasterControl.sharedInstance().getSelection().selectionCanRemove().cg
        if (nodeRefs.count > 0){
            raiseView(true)
        } else {
            raiseView(false)
        }
    }

}