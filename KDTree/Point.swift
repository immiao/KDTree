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
    var index: Int
    init(x: Float, y: Float, idx: Int) {
        self.p[0] = x
        self.p[1] = y
        index = idx
    }
}
