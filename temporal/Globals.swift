//
//  Globals.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
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

let TMPL_DEFAULT_BPM:Double = 120.0 //default Beats Per Minute
let TMPL_DEFAULT_MARGIN:Vec4 = Vec4(X: 8, Y: 8, Z: 8, W: 9) //default margin around views. || -margin- |content| -margin ||
let TMPL_DEFAULT_THEME:GUITheme = GUITheme(themeCol1: UIColor(white: 0.35, alpha: 1.0), themeCol2: UIColor(white: 0.5, alpha: 1.0), themeCol3: UIColor(white: 0.75, alpha: 1.0), themeCol4: UIColor.CrispColor())


func newTestSeqNode() -> GHSequenceNode
{
    return GHSequenceNode(frame: CGRectMake(0,0, 36, 36), seq: GHSequenceInfo())
}