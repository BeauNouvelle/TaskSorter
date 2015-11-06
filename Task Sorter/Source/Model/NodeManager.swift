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

        guard let node = self.rootNode else {
            return
        }
        
        let sortedNodes = recursiveInOrderTraversal(node)
        
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
        
        let target = search(title)
        
        // is root
        if target?.parent == nil {
            if target?.right != nil {
                let childLeft = target?.right?.left
                
                target?.title = target?.right?.title
                target?.right = target?.right?.right
                target?.left = childLeft
            }
        }
        
        // if its on the left of parent
        if target?.parent?.left?.title == target?.title {
            if target?.right != nil {
                target?.parent?.left = target?.right
            }
            if target?.left != nil {
                target?.parent?.left = target?.left
            }
            if target?.right == nil && target?.left == nil {
                target?.parent?.left = nil
            }
        }
        
        // if its on the right of parent
        if target?.parent?.right?.title == target?.title {
            if target?.right != nil {
                target?.parent?.right = target?.right
            }
            if target?.left != nil {
                target?.parent?.right = target?.left
            }
            if target?.left == nil && target?.right == nil {
                target?.parent?.right = nil
            }
        }
        
//        
//        let parent = target?.parent
//        var node: NodeTree?
//        
//        if target == nil {
//            return
//        }
//        
//        let isLeft = target == parent?.left
//        
//        if target == rootNode {
//            // get the last house on the left on the right
//            // it becomes the new root.
//            
//            print("Deleting ROOT NODE")
//            node = getLastHouseOnTheLeft(target?.right)
//            if node != nil {
//                node?.left = target?.left
//                node?.right = target?.right
//                rootNode = node
//            }
//        } else if target!.isLeaf() {
//            print("Deleting LEAF NODE")
//
//            if isLeft {
//                parent?.left = nil
//            } else {
//                parent?.right = nil
//            }
//        } else if target?.left != nil && target?.right != nil {
//            print("Deleting two children NODE")
//
//            if isLeft {
//                parent?.left = target?.right
//                parent?.left?.left = target?.left
//            } else {
//                parent?.right = target?.right
//                parent?.right?.left = target?.left
//            }
//        } else {
//            print("Deleting node with SINGLE child")
//
//            if target?.left == nil {
//                if isLeft {
//                    parent?.left = target?.left
//                } else {
//                    parent?.right = target?.left
//                }
//            } else {
//                if isLeft {
//                    parent?.left = target?.right
//                } else {
//                    parent?.right = target?.right
//                }
//            }
//        }
        saveNodesInSortedArray()
    }
    
    func getLastHouseOnTheLeft(inputNode: NodeTree!) -> NodeTree! {
        var candidate: NodeTree?
        var parent: NodeTree?
        var node = inputNode
        
        while node != nil {
            if node.left != nil {
                parent = node
                candidate = node.left
            }
            node = node.left
        }
        if parent != nil {
            parent?.left = nil
        }
        return candidate
    }
    
    func findNode(title: String!, node: NodeTree?) -> NodeTree? {
        if node != nil {
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
