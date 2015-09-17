//
//  Globals.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

let TMPL_DEFAULT_BPM:Double = 120.0 //default Beats Per Minute
let TMPL_DEFAULT_MARGIN:CGFloat = 32.0 //default margin around views. || -margin- |content| -margin ||

func newTestSeqNode() -> GHSequenceNode
{
    return GHSequenceNode(frame: CGRectMake(0,0, TMPL_DEFAULT_MARGIN, TMPL_DEFAULT_MARGIN), seq: GHSequenceInfo())
}