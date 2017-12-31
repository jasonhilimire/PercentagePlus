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
        let lifetimeShotsMade = shotCycles.reduce(0, {$0 + ($1.shotsMade )})
        print("lifetime Shots Made: \(lifetimeShotsMade)")
        return lifetimeShotsMade
    }
    
    func lifeTimeShootingPerc() -> Int {
        if shotCycles.count == 0 {
            return 0
        } else {
        let lifeTimeShootingPerc = (shotCycles.reduce(0, {$0 + ($1.cyclePercent )}) / shotCycles.count)
        print("lifetime Shooting Percent: \(lifeTimeShootingPerc)")
            return lifeTimeShootingPerc
        }
    }
    
    func lifeTimeShotCycles() -> Int {
        return shotCycles.count
    }
    
    func lifeTimeUR() -> Int {
        let lifetimeURShotsMade = shotCycles.reduce(0, {$0 + ($1.urHitCount )})
        print("lifetime UR Shots Made: \(lifetimeURShotsMade)")
        return lifetimeURShotsMade
    }
    
    func lifeTimeUL() -> Int {
        let lifetimeULShotsMade = shotCycles.reduce(0, {$0 + ($1.ulHitCount )})
        print("lifetime UL Shots Made: \(lifetimeULShotsMade)")
        return lifetimeULShotsMade
    }
    func lifeTimeBR() -> Int {
        let lifetimeBRShotsMade = shotCycles.reduce(0, {$0 + ($1.brHitCount )})
        print("lifetime BR Shots Made: \(lifetimeBRShotsMade)")
        return lifetimeBRShotsMade
    }
    
    func lifeTimeBL() -> Int {
        let lifetimeBLShotsMade = shotCycles.reduce(0, {$0 + ($1.blHitCount )})
        print("lifetime BL Shots Made: \(lifetimeBLShotsMade)")
        return lifetimeBLShotsMade
    }
    
}
