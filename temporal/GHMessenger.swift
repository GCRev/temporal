//
//  GHMessenger.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation

protocol GHMessengerDelegate
{

}

class GHMessenger:NSObject
{

    var targets:[GHMessenger]!

    override init() {
        super.init()
        targets = []
    }

}