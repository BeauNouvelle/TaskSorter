//
//  TreeNode.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import Foundation

class NodeTree<T: Comparable> {
    
    var key: T?
    var left: NodeTree?
    var right: NodeTree?
    
//    func addNode(key: T) {
//        
//        //check for the head node
//        if self.key == nil {
//            self.key = key
//            return
//        }
//        
//        // check the left side of the tree
//        if key < self.key {
//            if self.left != nil {
//                left?.addNode(key)
//            } else {
//                var leftChild = NodeTree()
//                leftChild.key = key
//                self.left = leftChild
//            }
//        }
//        
//        // check the right side of the tree
//        if key > self.key {
//            if self.right != nil {
//                right?.addNode(key)
//            } else {
//                var rightChild = NodeTree()
//                rightChild.key = key
//                self.right = rightChild
//            }
//        }
//    }
    
}
