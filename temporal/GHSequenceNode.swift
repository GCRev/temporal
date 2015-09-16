
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

    var sequenceInfo:GHSequenceInfo?

    init(frame: CGRect, seq: GHSequenceInfo) {
        super.init(frame: frame)
        self.sequenceInfo = seq
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}