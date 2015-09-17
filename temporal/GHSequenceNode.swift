
//
//  SequenceNode.swift
//  temporal
//
//  Created by Graham Held on 9/15/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

struct Vec4 {
    var X:CGFloat
    var Y:CGFloat
    var Z:CGFloat
    var W:CGFloat
}

class GHSequenceNode:GHView
{

    var sequenceInfo:GHSequenceInfo?
    var margin:CGFloat!
    let mainShape:CAShapeLayer = CAShapeLayer()

    init(frame: CGRect, seq: GHSequenceInfo) {
        super.init(frame: frame)
        self.sequenceInfo = seq
        let circlePath = UIBezierPath(ovalInRect: frame.bounds)
        mainShape.path = circlePath.CGPath
        mainShape.strokeColor = UIColor.MolestyRed().CGColor
        mainShape.fillColor = UIColor.clearColor().CGColor
        layer.addSublayer(mainShape)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutChildNodes() {
        let margin = GHMasterControl.sharedInstance().getMargin()
        var currSize = CGSizeZero
        for(var a = 0; a < childNodes.count; a++){
            let node = childNodes[a].getView()
            if let seq = node as? GHSequenceNode {
                seq.layoutChildNodes()
            }
            node.frame.origin = CGPointMake(currSize.w + margin, margin)
            currSize = CGSizeMake(currSize.w + node.frame.size.w + margin, max(currSize.h, node.frame.size.h))
        }
        frame.size = CGSizeMake(currSize.w + margin, currSize.h + ((1 + (childNodes.count>0).cg ) * margin))
        let bevelPath = UIBezierPath(roundedRect: frame.bounds, cornerRadius: frame.size.h/2)
        mainShape.path = bevelPath.CGPath
    }
    
}