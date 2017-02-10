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
    let w = Float(UIScreen.main.bounds.size.width)
    let h = Float(UIScreen.main.bounds.size.height)
    
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
        for _ in 0..<num {
            let point = Point(x: random(max: w), y: random(max: h))
            pointArray.append(point)
        }
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x:20, y:50))
        aPath.addLine(to: CGPoint(x:300, y:50))
        
        aPath.close()
        UIColor.red.set()
        aPath.stroke()
        aPath.fill()

        generateRandomPoints(10)
        for p in pointArray {
            let pathDot2 = UIBezierPath(ovalIn: CGRect.init(x: CGFloat(p.p[0]), y: CGFloat(p.p[1]), width: 8, height: 8))
            pathDot2.stroke()
            print(p.p[0], p.p[1])
        }
    }
}
