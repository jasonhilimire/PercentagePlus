//to
//  ShotCycle.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation


class ShotCycle: Codable {
    var date: String
    var totalPercentCalc: Int
    var summedShots: Int
    var currentShotCyclePercent: Int
    var summedShotsMade: Int
    var currentShotsMade: Int
    

    init?(date: String, totalPercentCalc: Int, summedShots: Int, currentShotCyclePercent: Int, summedShotsMade: Int, currentShotsMade: Int) {
        self.date = date
        self.totalPercentCalc = totalPercentCalc
        self.summedShots = summedShots
        self.currentShotCyclePercent = currentShotCyclePercent
        self.summedShotsMade = summedShotsMade
        self.currentShotsMade = currentShotsMade
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
    

    
    func printDescription() {
        print("Shot Cycle = Summed Shots = \(summedShots), Shots Made = \(summedShotsMade), Current Percent = \(currentShotCyclePercent), TotalPercentCalc = \(totalPercentCalc) ")
    }
//    mutating func totalShootingPerc(){
//        totalPercentCalc = ((summedShotsMade * 100) / summedShots)
//    }
    
}

