//
//  KDTree.swift
//  KDTree
//
//  Created by mac on 2/10/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation

struct node {
    var p: Point
    var axis: Int
    init (p: Point, axis: Int) {
        self.p = p;
        self.axis = axis;
    }
}

func getMaxElements(pointSize: Int) -> Int {
    let depth = Int(log2(Float(pointSize)))
    let max = Int(pow(2, Double(depth + 1)) + 0.5) - 1;
    return max
}

class KDTree {
    var nodeArray: [node?]
    var pointArray: [Point]
    
    init (pointArr: [Point]) {
        pointArray = pointArr
        nodeArray = [node?](repeating: nil, count: getMaxElements(pointSize: pointArray.count))
        print(pointArray.count, getMaxElements(pointSize: pointArray.count))
    }
    
    func build(left: Int, right: Int, axis: Int, crtIdx: Int) {
        var axis = axis
        if left > right {
            return
        }
        
        pointArray[left..<right + 1].sort{ $0.p[axis] < $1.p[axis] }
//        for p in pointArray {
//            print(p.p[0], p.p[1])
//        }
//        print("----")
        let mid: Int = (left + right) / 2
        nodeArray[crtIdx] = node(p: pointArray[mid], axis: axis)
        
        axis = (axis + 1) % 2
        build(left: left, right: mid - 1, axis: axis, crtIdx: crtIdx * 2 + 1)
        build(left: mid + 1, right: right, axis: axis, crtIdx: crtIdx * 2 + 2)
    }
    

}
