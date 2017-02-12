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

// uses array to store the nodes of the kd-tree, ensures the array is big enough
// size = pow(2, depth + 1) - 1, uses log2 to get the depth
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
    var kPointArray: [Point] = [Point]() // can only store the indices
    
    init (pointArray: [Point]) {
        self.pointArray = pointArray
        self.nodeArray = [node?](repeating: nil, count: getMaxElements(pointSize: pointArray.count))
        //self.kPointArray = [Point?](repeating: nil, count: k)
    }
    
    func distance2(_ p0: Point, _ p1: Point) -> Float{
        return pow(p0.p[0] - p1.p[0], 2) + pow(p0.p[1] - p1.p[1], 2)
    }
    
    func build(left: Int, right: Int, axis: Int, crtIdx: Int, _ min: [Float], _ max: [Float]) {
        if left > right {
            return
        }
        // sort and find the median
        pointArray[left..<right + 1].sort{ $0.p[axis] < $1.p[axis] }
        let mid: Int = (left + right) / 2
        
        // create node
        nodeArray[crtIdx] = node(p: pointArray[mid], axis: axis)
        
        // create paths for splitting axes
        let path = UIBezierPath()
        if axis == 0 {
            path.move(to: CGPoint(x: CGFloat(pointArray[mid].p[0]), y: CGFloat(min[1])))
            path.addLine(to: CGPoint(x: CGFloat(pointArray[mid].p[0]), y: CGFloat(max[1])))
        }
        else {
            path.move(to: CGPoint(x: CGFloat(min[0]), y: CGFloat(pointArray[mid].p[1])))
            path.addLine(to: CGPoint(x: CGFloat(max[0]), y: CGFloat(pointArray[mid].p[1])))
        }
        path.close()
        pathArray.append(path)
        pathColorArray.append(axis)
        
        // bounding box
        var newMin = min
        var newMax = max
        newMin[axis] = pointArray[mid].p[axis]
        newMax[axis] = pointArray[mid].p[axis]
        
        build(left: left, right: mid - 1, axis: axis ^ 1, crtIdx: crtIdx * 2 + 1, min, newMax)
        build(left: mid + 1, right: right, axis: axis ^ 1, crtIdx: crtIdx * 2 + 2, newMin, max)
    }
    
    func search(inputPoint: Point, k: Int) {
        kPointArray.removeAll()
        if k > 0 {
            findKnn(0, inputPoint, 0, k)
        }
    }
    
    func findKnn(_ nodeIdx: Int, _ p: Point, _ axis: Int, _ k: Int) {
        if nodeIdx >= nodeArray.count || nodeArray[nodeIdx] == nil {
            return
        }
        let left = nodeIdx * 2 + 1
        let right = nodeIdx * 2 + 2
        let crtPoint = (nodeArray[nodeIdx]?.p)!
        
        // update k nearest neighbours
        if kPointArray.count < k {
            kPointArray.append(crtPoint)
        }
        else {
            if distance2(kPointArray[k - 1], p) > distance2(crtPoint, p) {
                kPointArray[k - 1] = crtPoint
            }
        }
        kPointArray.sort{ distance2($0, p) < distance2($1, p) }
        
        // search sub-tree
        if (p.p[axis] <= crtPoint.p[axis]) {
            findKnn(left, p, (axis + 1) % 2, k)
            if kPointArray.count < k || fabsf(p.p[axis] - crtPoint.p[axis]) < distance2(p, kPointArray[k - 1]) {
                findKnn(right, p, (axis + 1) % 2, k)
            }
        }
        else {
            findKnn(right, p, (axis + 1) % 2, k)
            if kPointArray.count < k || fabsf(p.p[axis] - crtPoint.p[axis]) < distance2(p, kPointArray[k - 1]) {
                findKnn(left, p, (axis + 1) % 2, k)
            }
        }
        
    }
}
