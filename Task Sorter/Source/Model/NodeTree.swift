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
    var left: NodeTree?
    var right: NodeTree?
    
    init(title: String!) {
        super.init()
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        title = aDecoder.decodeObjectForKey("title") as! String
        left = aDecoder.decodeObjectForKey("left") as? NodeTree
        right = aDecoder.decodeObjectForKey("right") as? NodeTree
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(left, forKey: "left")
        aCoder.encodeObject(right, forKey: "right")
    }
    
}