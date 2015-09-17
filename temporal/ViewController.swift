//
//  ViewController.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("\(GHMasterControl.sharedInstance())")
        let testView = newTestSeqNode()
        view.addSubview(testView)

        let testView2 = newTestSeqNode()

        testView.addChildView(testView2)
        testView.addChildView(newTestSeqNode())

        testView2.addChildView(newTestSeqNode())
        testView2.addChildView(newTestSeqNode())
        
        testView.layoutChildNodes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

