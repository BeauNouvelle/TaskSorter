//
//  TreeNode.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import Foundation

class NodeTree: NSObject, NSCoding {
    
    var title: String!
    var parent: NodeTree?
    var left: NodeTree?
    var right: NodeTree?
    
    init(title: String!) {
        super.init()
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        parent = aDecoder.decodeObjectForKey("parent") as? NodeTree
        title = aDecoder.decodeObjectForKey("title") as! String
        left = aDecoder.decodeObjectForKey("left") as? NodeTree
        right = aDecoder.decodeObjectForKey("right") as? NodeTree
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(parent, forKey: "parent")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(left, forKey: "left")
        aCoder.encodeObject(right, forKey: "right")
    }
    
    func isLeaf() -> Bool {
        if left == nil && right == nil {
            return true
        }
        return false
    }
    
}