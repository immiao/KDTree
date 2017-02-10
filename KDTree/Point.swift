//
//  Point.swift
//  KDTree
//
//  Created by mac on 2/10/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation

class Point {
    var p = [Float](repeating: 0, count: 2)
    init(x: Float, y: Float) {
        self.p[0] = x
        self.p[1] = y
    }
}
