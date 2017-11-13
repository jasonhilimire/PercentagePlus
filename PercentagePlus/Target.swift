//
//  Targets.swift
//  BarDown
//
//  Created by Jason Hilimire on 11/12/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

struct Target {
    let targetName: String
    var targetHitCurrentCount: Int
    var targetHitTotalCount: Int
    
    init?(targetName: String, targetHitCount: Int) {
        self.targetName = targetName
        self.targetHitCount = targetHitCount
    }
}
