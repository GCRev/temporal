//
//  GHSequenceInfo.swift
//  temporal
//
//  Created by Graham Held on 9/15/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation

enum NoteType: UInt32{
    case Whole = 1
    case Half = 2
    case Quarter = 4
    case Eigth = 8
    case Sixteenth = 16
    case ThirtySecond = 32
    case SixtyFourth = 64
}

class GHSequenceInfo:NSObject
{
    var bpmOffset:Double! //this is an offset from the master BPM - so master changes are relative through children
    var beats:Int!
    var noteType:UInt32!

    init(bpm:Double = 0, beats:Int = 4, noteType:UInt32 = 4){
        super.init()
        self.bpmOffset = bpm - GHMasterControl.sharedInstance().getBPM()
        self.beats = beats
        self.noteType = noteType
    }

    convenience init(bpm:Double, beats:Int, noteType:NoteType){
        self.init(bpm: bpm, beats: beats, noteType: noteType.rawValue)
    }

    func getBPM() -> Double {
        return GHMasterControl.sharedInstance().getBPM() + bpmOffset
    }

    func setBPM(newBPM:Double) {
        bpmOffset = newBPM - GHMasterControl.sharedInstance().getBPM()
    }
}