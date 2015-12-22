
//
//  SequenceNode.swift
//  temporal
//
//  Created by Graham Held on 9/15/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit


class GHSequenceNode:GHView
{

    var sequenceInfo = GHSequenceInfo()
    var margin:CGFloat!
    let mainShape = CAShapeLayer()
    let playheadShape = CAShapeLayer()
    var playheadLocation:Double = 0.0
    var totalBeats:Int = 1
    var playheadIndex:Int = 0
    var state:PlayState = .Stopped
    private var selection = false
    var lastTime:CFTimeInterval = 0

    init(frame: CGRect, seq: GHSequenceInfo) {
        super.init(frame: frame)
        self.sequenceInfo = seq
        let circlePath = UIBezierPath(ovalInRect: frame.bounds)
        mainShape.path = circlePath.CGPath
        mainShape.strokeColor = UIColor.whiteColor().CGColor
        mainShape.lineWidth=0.5
        mainShape.fillColor = GHMasterControl.sharedInstance().theme.themeCol4.colorWithAlphaComponent(0.3).CGColor

        let playheadPath = UIBezierPath(rect: CGRectMake(0, 0, 1, frame.height))
        playheadShape.path = playheadPath.CGPath
        playheadShape.fillColor = UIColor.whiteColor().CGColor
        playheadShape.strokeColor = UIColor.clearColor().CGColor

        let maskShape = CAShapeLayer()
        maskShape.path = circlePath.CGPath
        maskShape.frame = frame.bounds
        mainShape.mask = maskShape

        layer.addSublayer(mainShape)
        mainShape.addSublayer(playheadShape)

        let tapRecog = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.addGestureRecognizer(tapRecog)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutChildNodes() {
        if (hasChildren()) {
            anchor = CGPointMake(frame.origin.x + frame.size.width / 2.0, frame.origin.y)
            let margin = GHMasterControl.sharedInstance().getMargin()
            var currSize = CGSizeZero
            for(var a = 0; a < childNodes.count; a++){
                let node = childNodes[a].getView()
                if let seq = node as? GHSequenceNode {
                    seq.layoutChildNodes()
                }
                node.frame.origin = CGPointMake(currSize.w + margin.X, margin.Y)
                currSize = CGSizeMake(currSize.w + node.frame.size.w + margin.Z + margin.X, max(currSize.h, node.frame.size.h))

                frame.size = CGSizeMake(currSize.w + (margin.Z - margin.X), currSize.h + ((1 + (childNodes.count>0).cg ) * margin.W))
            }
            let bevelPath = UIBezierPath(roundedRect: frame.bounds, cornerRadius: frame.size.h/3.3)
            mainShape.path = bevelPath.CGPath

        }
        else {
            frame.size = CGSizeMake(48,48)
            mainShape.path = UIBezierPath(ovalInRect: frame.bounds).CGPath
        }
        frame.origin = CGPointMake(anchor.x - frame.size.w / 2.0, anchor.y)
        let maskShape = CAShapeLayer()
        maskShape.path = mainShape.path
        maskShape.frame = frame.bounds
        mainShape.mask = maskShape
        playheadShape.path = UIBezierPath(rect: CGRectMake(playheadShape.frame.origin.x, 0, 1, frame.height)).CGPath
    }

    override func removeFromParent() {
        super.removeFromParent()
        GHMasterControl.sharedInstance().getSelection().deselectNode(self)
    }

    override func addChildView(view: GHView) {
        super.addChildView(view)
        sequenceInfo.setBeats(childNodes.count)
    }

    override func removeChildView(view: GHView) {
        super.removeChildView(view)
        sequenceInfo.setBeats(childNodes.count)
    }

    override func stop() {
        super.stop()
        state = .Stopped

        playheadShape.removeAllAnimations()

        playheadLocation = 0.0
        playheadIndex = 0
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        playheadShape.position.x = 0
        CATransaction.commit()

    }

    override func play() {
        super.play()
        state = .Playing
    }

    override func playFirst() {
        if hasChildren()
        {
            let node = childNodes[playheadIndex]
            node.playFirst()
        }

        if(state != .Playing)
        {
            state = .Playing
            totalBeats = calcTotalBeats()
            playAnim(calculateFullLength())
        }
    }

    func playAnim(duration:Double)
    {
        let anim = CABasicAnimation(keyPath: "position.x")
        anim.fromValue = 0
        anim.toValue = frame.width
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        anim.duration = duration
        anim.delegate = self
        anim.removedOnCompletion = true

        playheadShape.addAnimation(anim, forKey: "moveAnim")

    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if (state == .Playing && !hasChildren())
        {
            advanceIndex()
        }
    }

    func calcTotalBeats() ->Int
    {
        var result:Int = 0
        if (!hasChildren())
        {
            result = 1
        }
        for targ in childNodes
        {
            let cast = targ as! GHSequenceNode

            result += cast.calcTotalBeats()
        }

        return result
    }

    override func update(deltaT: Double) {
        /*
        super.update(deltaT)

        if (state == .Playing)
        {

            if (playheadLocation == 0)
            {
                playSound()
            }

            let diff = CACurrentMediaTime() - lastTime
            lastTime = CACurrentMediaTime()
            playheadLocation += diff

            if (playheadLocation >= sequenceInfo.totalLength)
            {
                advanceIndex()
            }
        }
        */

    }

    override func draw()
    {
        /*
        super.draw()
        dispatch_async(dispatch_get_main_queue(), {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.playheadShape.position.x = (self.playheadLocation / max(0.001,self.sequenceInfo.totalLength)).cg * self.frame.width
            CATransaction.commit()
        })
        */

    }

    func playSound()
    {
        if (sequenceInfo.accentType == .Normal)
        {
            GHMasterControl.sharedInstance().playLoPingSound()
        } else if (sequenceInfo.accentType == .Accent)
        {
            GHMasterControl.sharedInstance().playHiPingSound()
        }
    }

    func setGSelected(s:Bool){

        selection = s

        var toColor:UIColor!

        if (!selection) {
            toColor = GHMasterControl.sharedInstance().theme.themeCol4.colorWithAlphaComponent(0.3)
        } else {
            toColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        }

        mainShape.fillColor = toColor.CGColor

        let anim = CABasicAnimation(keyPath: "fillColor")
        anim.fromValue = UIColor.whiteColor().CGColor
        anim.toValue = toColor.CGColor

        anim.duration = 0.5
        mainShape.addAnimation(anim, forKey: "colorAnim")
    }

    func getGSelected() -> Bool {
        return selection
    }

    func advanceIndex()
    {

        playheadIndex+=1
        if(playheadIndex >= childNodes.count)
        {
            state = .Stopped
            let cast = getParent() as? GHSequenceNode
            if (cast != nil)
            {
                cast!.advanceIndex()
            }
            else //only applies to the highest level node
            {
                stop()
                playFirst()
            }
        } else
        {
            playFirst()
        }
    }

    func calculateFullLength() -> Double
    {

        sequenceInfo.setBeats(childNodes.count)
        var result:Double = 0.0
        for node in childNodes
        {
            let cast = node as! GHSequenceNode
            result += cast.calculateFullLength()

            //print(result)
        }
        if !hasChildren(){
            result = sequenceInfo.calculateTime()
        }

        //print(result)
        return result
    }

    func handleTap(tap:UITapGestureRecognizer) {

        let s = toggle(selection)
        if(s)
        {
            GHMasterControl.sharedInstance().getSelection().selectNode(self)
        } else {
            GHMasterControl.sharedInstance().getSelection().deselectNode(self)

        }

    }


    
}