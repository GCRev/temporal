//
//  GHMasterGUI.swift
//  temporal
//
//  Created by Graham Held on 9/17/15.
//  Copyright © 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit

struct GUITheme {
    var themeCol1:UIColor
    var themeCol2:UIColor
    var themeCol3:UIColor
    var themeCol4:UIColor
}

class GHMasterGUI:GHView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let margin = GHMasterControl.sharedInstance().getMargin()

        let tools = GHNodeTools(frame: CGRectMake(0, frame.height-128, frame.width, 128))
        addChildView(tools)

        let playButton = GHPlayButton(frame: CGRectMake(margin.X, frame.height - 128 + margin.Y, 128 - margin.X - margin.X, 128 - margin.Y - margin.Y))
        addChildView(playButton)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
