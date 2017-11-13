//
//  Targets.swift
//  BarDown
//
//  Created by Jason Hilimire on 11/12/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

struct Target {
    var targetHitCount: Int
    let targetName: String
    
    init?(targetName: String, targetHitCount: Int) {
        self.targetName = targetName
        self.targetHitCount = targetHitCount
    }  
}
