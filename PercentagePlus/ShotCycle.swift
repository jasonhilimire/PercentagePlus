//to
//  ShotCycle.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

var sliderValue: Int = 0
var incrementValue: Int = 0


//  move all this to its own model??
var totalPercentCalc = 0
var summedShots = 0
var currentShotCyclePercent = 0
var summedShotsMade = 0
var shootingCycle = 0
var activeCycle = false


var shotCycles = [ShotCycle]()

class ShotCycle: Codable {
    var date: String
    var totalPercentCalc: Int
    var summedShots: Int
    var cyclePercentage: Int
    var shotsMade: Int
    var currentShotsMade: Int
    var shotsTaken: Int
    

    init?(date: String, totalPercentCalc: Int, summedShots: Int, currentShotCyclePercent: Int, summedShotsMade: Int, currentShotsMade: Int, shotsTaken: Int) {
        self.date = date
        self.totalPercentCalc = totalPercentCalc
        self.summedShots = summedShots
        self.cyclePercentage = currentShotCyclePercent
        self.shotsMade = summedShotsMade
        self.currentShotsMade = currentShotsMade
        self.shotsTaken = shotsTaken
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
        print("Shot Cycle = Summed Shots = \(summedShots), Shots Made = \(shotsMade), Current Percent = \(cyclePercentage), TotalPercentCalc = \(totalPercentCalc) ")
    }
    

    
    

//    mutating func totalShootingPerc(){
//        totalPercentCalc = ((summedShotsMade * 100) / summedShots)
//    }
    
}


