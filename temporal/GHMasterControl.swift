//
//  GHMasterControl.swift
//  temporal
//
//  Created by Graham Held on 9/14/15.
//  Copyright (c) 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol GHMCProtocol : class
{
    func play()
    func playFirst()
    func pause()
    func stop()
    func getMaxSize() -> CGSize //gets the size of the all the subNodes based on max x and y coords.
                                //takes the local origin into account
    func getView() -> GHView
    func selectionChanged()
    func update(deltaT:Double)
    func draw()
}

class GHMasterControl:NSObject
{

    static let cntrl = GHMasterControl()
    private var targs:[GHMCProtocol] = []
    private var bpm:Double = TMPL_DEFAULT_BPM
    private var margin:Vec4 = TMPL_DEFAULT_MARGIN
    private let selection = GHNodeSelection()
    var masterNode:GHSequenceNode!
    var theme:GUITheme = TMPL_DEFAULT_THEME
    var updateTimer:NSTimer!
    var audioPlayer = AVAudioPlayer()
    var lastTime:CFTimeInterval = 0
    var count:Int = 0

    class func sharedInstance() -> GHMasterControl {
        return cntrl
    }

    override init()
    {
        super.init()
        //updateTimer = NSTimer(timeInterval: 1/60, target: self, selector: "update", userInfo: nil, repeats: true)
        //updateTimer = NSTimer.scheduledTimerWithTimeInterval(1/75, target: self, selector: "update", userInfo: nil, repeats: true)

        //NSRunLoop.mainRunLoop().addTimer(updateTimer, forMode: NSDefaultRunLoopMode)
        lastTime = CACurrentMediaTime()
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

    func playHiPingSound(){
        dispatch_async(dispatch_get_main_queue(), {
            let pingSound = GHAudioPrefs.sharedPrefs().getHiPingSound().path

            do {
                self.audioPlayer = try AVAudioPlayer(contentsOfURL: pingSound)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
            catch
            {
                print("fuck you")
            }
            }
        )

    }

    func playLoPingSound(){
        dispatch_async(dispatch_get_main_queue(), {
            let pingSound = GHAudioPrefs.sharedPrefs().getLoPingSound().path

            do {
                self.audioPlayer = try AVAudioPlayer(contentsOfURL: pingSound)
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }
            catch
            {
                print("fuck you")
            }
            }
        )
        
    }

    func removeTarg(ind:Int){
        targs.removeAtIndex(ind)
    }

    func getBPM() -> Double {
        return bpm
    }

    func getSelection() -> GHNodeSelection {
        return selection
    }

    func selectionChanged() {
        for targ in targs {
            targ.selectionChanged()
        }
    }

    func getMargin() -> Vec4 {
        return margin
    }

    func play(){
        masterNode.calculateFullLength()
        for targ in targs {
            targ.play()
        }
    }

    func playFirst()
    {
        masterNode.calculateFullLength()
        for targ in targs
        {
            targ.playFirst()
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

    func update()
    {
        for targ in targs {
            targ.update(0)
        }

        if (count == 0)
        {
            for targ in targs {
                targ.draw()
            }
        }

        count += 1

        if (count > 1)
        {
            count = 0
            
        }

    }

}