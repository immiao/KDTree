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
    var pathArray = [UIBezierPath]()
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
        pathArray.removeAll()
        pointArray.removeAll()
        for i in 0..<num {
            let point = Point(x: random(max: w), y: random(max: h), idx: i)
            pointArray.append(point)
            pathArray.append(UIBezierPath(ovalIn: CGRect.init(x: CGFloat(point.p[0]), y: CGFloat(point.p[1]), width: 8, height: 8)))
        }
    }
    
    func buildKdTree() {
        if pointArray.count != 0 {
            kdtree = KDTree(pointArr: pointArray)
            kdtree?.build(left: 0, right: pointArray.count - 1, axis: 0, crtIdx: 0)
        }
        else {
            print("No Points Exist!")
        }
    }
    
    override func draw(_ rect: CGRect) {
        
//        aPath.move(to: CGPoint(x:20, y:50))
//        aPath.addLine(to: CGPoint(x:300, y:50))
//        
//        aPath.close()
//        UIColor.red.set()
//        aPath.stroke()
//        aPath.fill()
        for p in pathArray {
            p.stroke()
        }
    }
}
