//to
//  ShotCycle.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

var sliderValue: Int = 0



//  move all this to its own model??





class ShotCycle: Codable {
    var date: String
    var shotsTaken: Int
    var cyclePercent: Int
    var shotsMade: Int

    var ulHitCount: Int
    var urHitCount: Int
    var blHitCount: Int
    var brHitCount: Int
    

    init?(date: String, shotsTaken: Int, cyclePercent: Int, shotsMade: Int, ulHitCount: Int, urHitCount: Int, blHitCount: Int, brHitCount: Int) {
        self.date = date
        self.shotsTaken = shotsTaken
        self.cyclePercent = cyclePercent
        self.shotsMade = shotsMade
        self.ulHitCount = ulHitCount
        self.urHitCount = urHitCount
        self.blHitCount = blHitCount
        self.brHitCount = brHitCount
        
    }
    
    func sumHitCounts(ulHitCount: Int, urHitCount: Int, blHitCount: Int, brHitCount: Int) -> Int {
        let totalShotsMade = (ulHitCount + urHitCount + blHitCount + brHitCount)
        print("Total Shots Made: \(totalShotsMade)")
        return totalShotsMade
    }
    
    func getCyclePercent(shotsTaken: Int, shotsMade: Int) -> Int {
        let cyclePerc = (shotsTaken * 100) / shotsMade
        return cyclePerc
    }
    
    
}


