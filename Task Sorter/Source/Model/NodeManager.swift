//
//  NodeManager.swift
//  Task Sorter
//
//  Created by Beau Young on 3/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class NodeManager: NSObject {

    static let sharedManager = NodeManager()
    var rootNode: NodeTree?
    
    enum Keys: String {
        case TopNode = "TaskSorterTopNode"
        case SortedNodes = "TaskSorterSortedNodes"
    }
    
    // MARK: Functions
    private override init() {
        super.init()
        rootNode = topNode()
    }
    
    func hasFirstNode() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let _ = defaults.valueForKey(Keys.TopNode.rawValue) as? NSData {
            print("Has First Node")
            return true
        } else {
            return false
        }
    }
    
    /**
     Fetches rootnode from NSUserDefualts.
     - returns: the root node for the entire app.
     */
    func topNode() -> NodeTree? {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let encodedNode = defaults.valueForKey(Keys.TopNode.rawValue) as? NSData {
            let node = NSKeyedUnarchiver.unarchiveObjectWithData(encodedNode) as! NodeTree
            return node
        } else {
            return nil
        }
    }
    
    /**
     Used to create a new root node for the entire app. Using this will wipe any nodes already in use.
     - parameter title: The task title for the top node.
     */
    func createTopNode(title: String!) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let node = NodeTree(title: title)
        rootNode = node
        let encodedNode = NSKeyedArchiver.archivedDataWithRootObject(node)
         defaults.setObject(encodedNode, forKey: Keys.TopNode.rawValue)
        defaults.synchronize()
    }
    
    /**
     Returns an array of already sorted nodes previously stored in user defaults. These are generated whenever `saveNodesInSortedArray` is called.
     - returns: Array of sorted nodes.
     */
    func sortedNodes() -> [NodeTree]! {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        guard let encodedSortedNodes = defaults.objectForKey(Keys.SortedNodes.rawValue) as? NSData else {
            return [NodeTree]()
        }
        
        let sortedNodes = NSKeyedUnarchiver.unarchiveObjectWithData(encodedSortedNodes) as! [NodeTree]
        return sortedNodes
    }
    
    /**
     Saves the root node and all its decendents as well as generating a sorted array of all nodes.
     */
    func saveNodesInSortedArray() {

        guard let node = self.rootNode else {
            return
        }
        
        let sortedNodes = recursiveInOrderTraversal(node)
       
        for node in sortedNodes {
            print(node.title)
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let encodedRootNode = NSKeyedArchiver.archivedDataWithRootObject(node)
        let encodedArray = NSKeyedArchiver.archivedDataWithRootObject(sortedNodes)
        
        defaults.setObject(encodedArray, forKey: Keys.SortedNodes.rawValue)
        defaults.setObject(encodedRootNode, forKey: Keys.TopNode.rawValue)
        defaults.synchronize()
    }
    
    func recursiveInOrderTraversal(root: NodeTree?) -> [NodeTree]! {
        if root == nil {
            return []
        }
        
        var result = [NodeTree]()
        
        result += recursiveInOrderTraversal(root!.left)
        result.append(root!)
        result += recursiveInOrderTraversal(root!.right)
        return result
    }

    
}
