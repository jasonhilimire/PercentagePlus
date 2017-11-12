//to
//  ShotCycle.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation


struct ShotCycle {
    var date = NSDate()
    var totalPercentCalc: Int
    var summedShots: Int
    var currentShotCyclePercent: Int
    var summedShotsMade: Int
    var currentShotsMade: Int
    

    init?(date: NSDate, totalPercentCalc: Int, summedShots: Int, currentShotCyclePercent: Int, summedShotsMade: Int, currentShotsMade: Int) {
        self.date = date
        self.totalPercentCalc = totalPercentCalc
        self.summedShots = summedShots
        self.currentShotCyclePercent = currentShotCyclePercent
        self.summedShotsMade = summedShotsMade
        self.currentShotsMade = currentShotsMade
    }
    
    func printDescription() {
        print("Shot Cycle = Summed Shots = \(summedShots), Shots Made = \(summedShotsMade), Current Percent = \(currentShotCyclePercent), TotalPercentCalc = \(totalPercentCalc) ")
    }
    
}

