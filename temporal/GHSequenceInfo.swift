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

enum AccentType {
    case None
    case Normal
    case Accent
}

class GHSequenceInfo:NSObject
{
    private var bpmOffset:Double! //this is an offset from the master BPM - so master changes are relative through children
    private var beats:Int!
    var noteType:UInt32!
    var numRepeats:UInt16!
    var totalLength:Double = 0.0
    var accentType:AccentType = .Normal
    private var numPlays:UInt16 = 0

    init(bpm:Double = 0, beats:Int = 1, noteType:UInt32 = 4, numRepeats:UInt16 = 0, accentType:AccentType = .Normal){
        super.init()
        self.bpmOffset = bpm
        self.beats = beats
        self.noteType = noteType
        self.numRepeats = numRepeats
        self.accentType = accentType
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

    func setBeats(num:Int)
    {
        beats = max(1,num)
    }

    func incrementNumPlays() -> Bool
    {
        numPlays += 1
        if (numPlays > numRepeats)
        {
            resetNumPlays()
        }
        return numPlays > numRepeats
    }

    func resetNumPlays()
    {
        numPlays = 0
    }

    func calculateTime() -> Double
    {
        var result:Double = 0.0
        //beats per second *
        result = (getBPM()/60) / Double(noteType) * Double(beats) * Double(numRepeats + 1)
        print(result)
        totalLength = result
        return result
    }
}