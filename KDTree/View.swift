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
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath();
        aPath.move(to: CGPoint(x:20, y:50))
        aPath.addLine(to: CGPoint(x:300, y:50))
        
        aPath.close()
        UIColor.red.set()
        aPath.stroke()
        aPath.fill()
        
        let pathDot = UIBezierPath(ovalIn: CGRect.init(x: 100, y:100, width: 8, height: 8))
        let pathDot2 = UIBezierPath(ovalIn: CGRect.init(x: 102, y:102, width: 8, height: 8))
        pathDot.stroke()
        pathDot2.stroke()
    }
}
