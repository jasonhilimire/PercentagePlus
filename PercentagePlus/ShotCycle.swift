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
        self.totalPercentCalc = totalPercentCalc
        self.summedShots = summedShots
        self.currentShotCyclePercent = currentShotCyclePercent
        self.summedShotsMade = summedShotsMade
        self.currentShotsMade = currentShotsMade
    }
    
    struct HistoryShotCycle {
        var historySummedShots = shotCycles.reduce(0) { $0 + ($1.summedShots)}
        var historySummedShotsMade = shotCycles.reduce(0) { $0 + ($1.summedShotsMade)}
        var historyShotCyclePercent = (shotCycles.reduce(0) { $0 + ($1.currentShotCyclePercent)} / (shotCycles.count)) // do I need a plus 1?
        
        init?(historySummedShots: Int, historySummedShotsMade: Int, historyShotCyclePercent: Int ) {
            self.historySummedShots = historySummedShots
            self.historySummedShotsMade = historySummedShotsMade
            self.historyShotCyclePercent = historyShotCyclePercent
        }
        
    }
    
    func dateFormatter() -> String{
        let currentDate = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let dateString = formatter.string(from: currentDate as Date)
        print("\(dateString)")
        return dateString
        
    }
    
    func sumHitCounts(ulHitCount: Int, urHitCount: Int, blHitCount: Int, brHitCount: Int) -> Int {
        let totalShotsMade = (ulHitCount + urHitCount + blHitCount + brHitCount)
        return totalShotsMade
    }
    
    func getCyclePercent(shotsTaken: Int, shotsMade: Int) -> Int {
        if shotsMade == 0 {
            return 0
        } else {
            let cyclePerc = (shotsMade * 100) / shotsTaken
            print("calculated %: \(cyclePerc)%")
            return cyclePerc
        }
    }
    
}


