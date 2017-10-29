//to
//  ShotCycle.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation


struct ShotCycle {
    var totalPercentCalc: Int
    var summedShots: Int
    var summedPercentCalc: Int
    var summedShotsMade: Int
    var date = NSDate()

    init?(date: NSDate, totalPercentCalc: Int, summedShots: Int, summedPercentCalc: Int, summedShotsMade: Int) {
        self.date = date
        self.totalPercentCalc = totalPercentCalc
        self.summedShots = summedShots
        self.summedPercentCalc = summedPercentCalc
        self.summedShotsMade = summedShotsMade
    }
    
    func printDescription() {
        print("Shot Cycle = Summed Shots = \(summedShots), Shots Made = \(summedShotsMade), Current Percent = \(summedPercentCalc), TotalPercentCalc = \(totalPercentCalc) ")
    }
    
}

