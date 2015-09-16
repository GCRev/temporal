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
    var childNodes:[GHMCProtocol]!
    var parent:GHView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        childNodes = [];
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addChildView(view: GHView){
        childNodes.append(view)
        view.mcIndex = childNodes.count - 1
        view.parent = self
        addSubview(view)
    }

    func removeChildView(view: GHView){
        childNodes.removeAtIndex(view.mcIndex!)
        view.removeFromSuperview()
    }

//    deinit {
//        GHMasterControl.sharedInstance().removeTarg(mcIndex)
//        println("\(mcIndex)")
//    }

    func play() {
        for node in childNodes {
            node.play()
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

}