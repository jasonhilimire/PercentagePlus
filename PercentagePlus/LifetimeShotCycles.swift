//
//  LifetimeShotCycls.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/13/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

class LifetimeShotCycle {
    
    func lifeTimeShotsTaken() -> Int {
        let lifetimeShotsTaken = shotCycles.reduce(0, {$0 + ($1.shotsTaken )})
        print("lifetime Shots Taken: \(lifetimeShotsTaken)")
        return lifetimeShotsTaken
        
    }
    
    func lifeTimeShotsMade() -> Int {
        let lifetimeShotsMade = shotCycles.reduce(0, {$0 + ($1.currentShotsMade )})
        print("lifetime Shots Made: \(lifetimeShotsMade)")
        return lifetimeShotsMade
    }
    
    func lifeTimeShootingPerc() -> Int {
        if shotCycles.count == 0 {
            return 0
        } else {
        let lifeTimeShootingPerc = (shotCycles.reduce(0, {$0 + ($1.currentShotCyclePercent )}) / shotCycles.count)
        print("lifetime Shooting Percent: \(lifeTimeShootingPerc)")
            return lifeTimeShootingPerc
        }
    }
    
}
