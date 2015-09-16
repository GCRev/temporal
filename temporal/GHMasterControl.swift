//
//  GHMasterControl.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation

protocol GHMCProtocol : class
{
    func play()
    func pause()
    func stop()
}

class GHMasterControl:NSObject
{

    static let cntrl = GHMasterControl()
    private var targs:[GHMCProtocol] = []
    private var bpm:Double = TMPL_DEFAULT_BPM

    class func sharedInstance() -> GHMasterControl {
        return cntrl
    }

    func addTarg(targ:GHMCProtocol) -> Int{
        targs.append(targ)
        return targs.count - 1
    }

    func removeTarg(targ:GHMCProtocol){
        for(var i = 0; i<targs.count; i++){
            if (targs[i] === targ){
                targs.removeAtIndex(i)
            }
        }
    }

    func removeTarg(ind:Int){
        targs.removeAtIndex(ind)
    }

    func getBPM() -> Double {
        return bpm
    }

    func play(){
        for targ in targs {
            targ.play()
        }
    }

    func pause(){
        for targ in targs {
            targ.pause()
        }
    }

    func stop(){
        for targ in targs {
            targ.stop()
        }
    }

}