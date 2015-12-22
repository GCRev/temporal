//
//  ViewController.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var contentScrollView:UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("\(GHMasterControl.sharedInstance())")

        let masterNode = GHSequenceNode(frame: CGRectMake(view.frame.width/2.0-24, 24, 48, 48), seq: GHSequenceInfo())
        GHMasterControl.sharedInstance().addTarg(masterNode)
        GHMasterControl.sharedInstance().masterNode = masterNode
        masterNode.setRemovable(false)


        view.backgroundColor = GHMasterControl.sharedInstance().theme.themeCol1

        let GUI = GHMasterGUI(frame: view.frame)
        view.addSubview(GUI)
        GUI.addChildView(masterNode)

        GHMasterControl.sharedInstance().addTarg(GUI)

        let tap = UITapGestureRecognizer(target: self, action: "bgTap")
        view.addGestureRecognizer(tap)

        contentScrollView = UIScrollView(frame: CGRectMake(0,30,view.frame.width,view.frame.height-30))
        contentScrollView.clipsToBounds = true
        view.addSubview(contentScrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bgTap()
    {
        GHMasterControl.sharedInstance().getSelection().deselectAll()
    }

}

