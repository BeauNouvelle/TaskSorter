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
        let defaults = NSUserDefaults.standardUserDefaults()
        
        guard let node = rootNode else {
            defaults.setObject(nil, forKey: Keys.SortedNodes.rawValue)
            defaults.setObject(nil, forKey: Keys.TopNode.rawValue)
            return
        }
        
        let sortedNodes = recursiveInOrderTraversal(node)
        
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
    
    /**
     Finds a node with the given name in the node tree.
     - parameter title: The title of the node you want to find.
     - returns: The node that was found, or nil if node isn't present.
     */
    func search(title: String!) -> NodeTree? {
        guard hasFirstNode() else {
            return nil
        }
        
        return findNode(title, node: rootNode)
    }
    
    func deleteNode(title: String) {
        
        var target = search(title)
        
        if target?.title == rootNode?.title {                   // is root node
            print("is root")
            
            if target?.right == nil {
                print("no right")
                rootNode = target?.left
            } else if target?.left == nil {
                print("no left")
                rootNode = target?.right
            } else {
                print("Root has two children")
                let lastNodeOnLeft = getLastOnLeft(target?.right)
                lastNodeOnLeft.left = target?.left
                target?.left?.parent = lastNodeOnLeft
                rootNode = target?.right
            }
            target = nil
            rootNode?.parent = nil
        } else if target!.isLeaf() {                                // is leaf. delete easily.
            print("is leaf")
            if target?.parent?.left == target {
                target?.parent?.left = nil
            } else {
                target?.parent?.right = nil
            }
            target = nil
        } else if target?.right != nil && target?.left != nil {    // has two children
            if target?.parent?.left == target {    // is left
                let lastNodeOnLeft = getLastOnLeft(target?.right)
                lastNodeOnLeft.left = target?.left
                target?.parent?.left = target?.right
                target?.right?.parent = target?.parent
                target = nil
            } else {                               // is right
                let lastNodeOnLeft = getLastOnLeft(target?.right)
                lastNodeOnLeft.left = target?.left
                target?.parent?.right = target?.right
                target?.right?.parent = target?.parent
                target = nil
            }
        } else {                                                   // has one child
            if target?.left == nil {
                if target?.parent?.left == target {
                    target?.parent?.left = target?.right
                    target?.right?.parent = target?.parent
                    target = nil
                } else {
                    target?.parent?.right = target?.right
                    target?.right?.parent = target?.parent
                    target = nil
                }
            } else {
                if target?.parent?.left == target { //less than largest after medium > large deleted
                    target?.parent?.left = target?.left
                    target?.left?.parent = target?.parent
                    target = nil
                } else {
                    target?.parent?.right = target?.left
                    target?.left?.parent = target?.parent
                    target = nil
                }
            }
        }
        
        saveNodesInSortedArray()
    }
    
    func getLastOnLeft(inputNode: NodeTree!) -> NodeTree! {
        var candidate: NodeTree?
        var tempNode = inputNode
        
        while tempNode != nil {
            if tempNode.left != nil {
                candidate = tempNode.left
            } else {
                candidate = tempNode
            }
            tempNode = tempNode.left
        }
        
        return candidate
    }
    
    func findNode(title: String!, node: NodeTree?) -> NodeTree? {
        if node != nil {
            print("FIND NODE: \(node?.title)  PARENT: \(node?.parent?.title)")
            if node?.title == title {
                return node
            } else {
                var foundNode = findNode(title, node: node?.left)
                if foundNode == nil {
                    foundNode = findNode(title, node: node?.right)
                }
                return foundNode
            }
        } else {
            return nil
        }
    }
    
}
