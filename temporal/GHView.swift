//
//  GHView.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

class GHView:UIView, GHMCProtocol
{

    var mcIndex:Int?
    var childNodes:[GHView] = [];
    private var parent:GHView?
    private var removable = true
    var anchor:CGPoint = CGPointZero

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addChildView(view: GHView){
        childNodes.append(view)
        view.mcIndex = childNodes.count - 1
        view.parent = self
        addSubview(view)
    }

    func removeChildView(view: GHView){
        if (view.removable)
        {
            childNodes.removeAtIndex(view.mcIndex!)
            view.removeFromSuperview()
        }
        rebrandChildren()
    }

    func rebrandChildren()
    {
        for (var a = 0; a < childNodes.count; a++)
        {
            let node = childNodes[a];
            node.mcIndex = a;
        }
    }

    func getParent() ->GHView?
    {
        return parent
    }

    func setRemovable(r:Bool){
        removable = r;
    }

    func getRemovable() -> Bool
    {
        return removable
    }

    func removeFromParent(){
        if (removable && parent != nil)
        {
            parent!.removeChildView(self)
        }

        if (parent == nil)
        {
            print("View: \(self) has no parent.")
        }
    }

//    deinit {
//        GHMasterControl.sharedInstance().removeTarg(mcIndex)
//        println("\(mcIndex)")
//    }

    func selectionChanged(){
        for node in childNodes
        {
            node.selectionChanged()
        }
    }

    func getMaxSize() -> CGSize {
        var result = CGSizeZero
        if (hasChildren()){
            for node in childNodes {
                result = CGSizeMake(max(result.w, node.getMaxSize().w), max(result.h, node.getMaxSize().h))
            }
        }
        else {
            result = CGSizeMake(frame.size.w + frame.origin.x, frame.size.h + frame.origin.y)
        }
        return result
    }

    func hasChildren() -> Bool {
        return childNodes.count > 0
    }

    func getView() -> GHView {
        return self;
    }

    func play() {
        for node in childNodes {
            node.play()
        }
    }

    func playFirst()
    {
        if hasChildren()
        {
        let node = childNodes[0]
            node.playFirst()
        } else {
            play()
        }
    }

    func pause() {
        for node in childNodes {
            node.pause()
        }
    }

    func stop() {
        for node in childNodes {
            node.stop()
        }
    }

    func update(deltaT:Double)
    {
        for node in childNodes
        {
            node.update(deltaT)
        }
    }

    func draw()
    {
        for node in childNodes
        {
            node.draw()
        }
    }

    func done()
    {
        
    }

}