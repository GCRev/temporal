//
//  GHAudioPrefs.swift
//  temporal
//
//  Created by Graham Held on 10/9/15.
//  Copyright © 2015 Latch Creative. All rights reserved.
//

import Foundation
import AVFoundation

struct GHAudio {
    var name:String
    var path:NSURL
}

class GHAudioPrefs:NSObject
{

    static let prefs = GHAudioPrefs()
    var hiPing:GHAudio?
    var loPing:GHAudio?
    let hiPingList:Array<GHAudio> = [
        GHAudio(name: "HighPing1", path: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("HiPing", ofType: "wav")!))
    ]
    let loPingList:Array<GHAudio> = [
        GHAudio(name: "LowPing1", path: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("LoPing", ofType: "wav")!))
    ]

    class func sharedPrefs() -> GHAudioPrefs
    {
        return prefs
    }

    func setHiPingSound(index:Int){
        hiPing = hiPingList[max(0,min(index, hiPingList.count-1))]
    }

    func setLoPingSound(index:Int){
        loPing = loPingList[max(0,min(index, hiPingList.count-1))]
    }

    func getHiPingSound() -> GHAudio {
        var result:GHAudio!
        if (hiPing != nil)
        {
            result = hiPing
        } else {
            result = hiPingList.first
        }
        return result
    }

    func getLoPingSound() -> GHAudio {
        var result:GHAudio!
        if (loPing != nil)
        {
            result = loPing
        } else {
            result = loPingList.first
        }
        return result
    }

}