//
//  View.swift
//  KDTree
//
//  Created by mac on 2/10/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import UIKit

class View: UIView {
    
    var pointArray = [Point]()
    var pointPathArray = [UIBezierPath]()
    var kdtree: KDTree? = nil
    let w = Float(UIScreen.main.bounds.size.width)
    let h = Float(UIScreen.main.bounds.size.height - 100)
    let path = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func random(max: Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * max;
    }
    
    func generateRandomPoints(_ num: Int) {
        // clear previous paths
        pointArray.removeAll()
        pointPathArray.removeAll()

        for i in 0..<num {
            let point = Point(x: random(max: w), y: random(max: h), idx: i)
            pointArray.append(point)
//            pointPathArray.append(UIBezierPath(ovalIn: CGRect.init(x: CGFloat(point.p[0]), y: CGFloat(point.p[1]), width: 8, height: 8)))
            pointPathArray.append(UIBezierPath(arcCenter: CGPoint(x: CGFloat(point.p[0]), y: CGFloat(point.p[1])), radius: CGFloat(4), startAngle: CGFloat(0), endAngle: CGFloat(M_PI * 2), clockwise: true))
        }
        setNeedsDisplay()
    }
    
    func buildKdTree() {
        if pointArray.count != 0 {
            kdtree = KDTree(pointArray: pointArray)
            let min = [Float(0.0), Float(0.0)]
            let max = [w, h]
            kdtree?.build(left: 0, right: pointArray.count - 1, axis: 0, crtIdx: 0, min, max)
        }
        else {
            print("No Points Exist!")
        }
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        for p in pointPathArray {
            p.stroke()
        }
        if kdtree != nil {
            print((kdtree?.pathArray.count)!)
            for i in (0...((kdtree?.pathArray.count)! - 1)) {
                if kdtree?.pathColorArray[i] == 0 {
                    UIColor.red.set()
                }
                else {
                    UIColor.blue.set()
                }
                kdtree?.pathArray[i].stroke()
            }
        }
    }
}
