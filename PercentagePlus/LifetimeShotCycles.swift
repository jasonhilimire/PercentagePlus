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
        return lifetimeShotsTaken
        
    }
    
    func lifeTimeShotsMade() -> Int {
        let lifetimeShotsMade = shotCycles.reduce(0, {$0 + ($1.shotsMade )})
        return lifetimeShotsMade
    }
    
    func lifeTimeShootingPerc() -> Int {
        if shotCycles.count == 0 {
            return 0
        } else {
        let lifeTimeShootingPerc = (shotCycles.reduce(0, {$0 + ($1.cyclePercent )}) / shotCycles.count)
            return lifeTimeShootingPerc
        }
    }
    
    func lifeTimeShotCycles() -> Int {
        return shotCycles.count
    }
    
    func lifeTimeUR() -> Int {
        let lifetimeURShotsMade = shotCycles.reduce(0, {$0 + ($1.urHitCount )})
        return lifetimeURShotsMade
    }
    
    func lifeTimeUL() -> Int {
        let lifetimeULShotsMade = shotCycles.reduce(0, {$0 + ($1.ulHitCount )})
        return lifetimeULShotsMade
    }
    func lifeTimeBR() -> Int {
        let lifetimeBRShotsMade = shotCycles.reduce(0, {$0 + ($1.brHitCount )})
        return lifetimeBRShotsMade
    }
    
    func lifeTimeBL() -> Int {
        let lifetimeBLShotsMade = shotCycles.reduce(0, {$0 + ($1.blHitCount )})
        return lifetimeBLShotsMade
    }
    
}
