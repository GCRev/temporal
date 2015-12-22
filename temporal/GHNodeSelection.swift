//
//  GHSelection.swift
//  temporal
//
//  Created by Graham Held on 10/2/15.
//  Copyright © 2015 Latch Creative. All rights reserved.
//

import Foundation
import UIKit


class GHNodeSelection : NSObject
{

    private var nodes:NSMutableArray = [];

    override init()
    {
        super.init()
    }

    func selectionHasChildren() -> Bool
    {
        var found = false
        for(var a = 0; a<nodes.count && !found; a++)
        {
            let node = nodes[a] as! GHSequenceNode
            found = node.hasChildren()
        }
        return found
    }

    func selectionCanRemove() -> Bool
    {
        var found = false
        for(var a = 0; a<nodes.count && !found; a++)
        {
            let node = nodes[a] as! GHSequenceNode
            found = node.getRemovable()
        }
        return found
    }

    func selectNode(node:GHSequenceNode)
    {
        nodes.addObject(node)
        node.setGSelected(true)
        GHMasterControl.sharedInstance().selectionChanged()
    }

    func selectNodes(nodeList:[GHSequenceNode])
    {
        nodes.addObjectsFromArray(nodeList)
        GHMasterControl.sharedInstance().selectionChanged()
    }

    func deselectNode(node:GHSequenceNode){
        nodes.removeObject(node)
        node.setGSelected(false)
        GHMasterControl.sharedInstance().selectionChanged()
    }

    func deselectAll(){
        for node in nodes
        {
            node.setGSelected(false)
        }
        nodes.removeAllObjects()
        GHMasterControl.sharedInstance().selectionChanged()
    }

    func getNodes() -> [GHSequenceNode] {
        return nodes as NSArray as! [GHSequenceNode]
    }

}