//
//  KDTree.swift
//  KDTree
//
//  Created by mac on 2/10/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import UIKit

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
    var pathArray = [UIBezierPath]()
    var pathColorArray = [Int]()
    
    init (pointArray: [Point]) {
        self.pointArray = pointArray
        self.nodeArray = [node?](repeating: nil, count: getMaxElements(pointSize: pointArray.count))
        //self.pointArray[0] = Point(x: 100, y: 100, idx: -1)
        //print(pointArray.count, getMaxElements(pointSize: pointArray.count))
    }
    
    func build(left: Int, right: Int, axis: Int, crtIdx: Int, _ min: [Float], _ max: [Float]) {
        if left > right {
            return
        }
        
        pointArray[left..<right + 1].sort{ $0.p[axis] < $1.p[axis] }
        let mid: Int = (left + right) / 2
        nodeArray[crtIdx] = node(p: pointArray[mid], axis: axis)
        let path = UIBezierPath()
        if axis == 0 {
            path.move(to: CGPoint(x: CGFloat(pointArray[mid].p[0]), y: CGFloat(min[1])))
            path.addLine(to: CGPoint(x: CGFloat(pointArray[mid].p[0]), y: CGFloat(max[1])))
        } else {
            path.move(to: CGPoint(x: CGFloat(min[0]), y: CGFloat(pointArray[mid].p[1])))
            path.addLine(to: CGPoint(x: CGFloat(max[0]), y: CGFloat(pointArray[mid].p[1])))
        }
        path.close()
        pathArray.append(path)
        pathColorArray.append(axis)
        
        var newMin = min
        var newMax = max
        newMin[axis] = pointArray[mid].p[axis]
        newMax[axis] = pointArray[mid].p[axis]
        
        build(left: left, right: mid - 1, axis: axis ^ 1, crtIdx: crtIdx * 2 + 1, min, newMax)
        build(left: mid + 1, right: right, axis: axis ^ 1, crtIdx: crtIdx * 2 + 2, newMin, max)
    }
    
    func search(nodeIdx: Int, p: Point) {
        
    }
}
