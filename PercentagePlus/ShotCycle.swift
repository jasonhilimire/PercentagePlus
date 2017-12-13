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

//MARK:- Target Set up
var upperRight = Target(targetName: "Upper Right", targetHitCurrentCount: 0, targetHitTotalCount: 0)
var upperRightHitCount = upperRight!.targetHitCurrentCount
var urTotal = upperRight!.targetHitTotalCount

var upperLeft = Target(targetName: "Upper Left" , targetHitCurrentCount: 0, targetHitTotalCount: 0)
var upperLeftHitCount = upperLeft!.targetHitCurrentCount
var ulTotal = upperLeft!.targetHitTotalCount

var lowerLeft = Target(targetName: "Lower Left", targetHitCurrentCount: 0, targetHitTotalCount: 0)
var lowerLeftHitCount = lowerLeft!.targetHitCurrentCount
var lrTotal = lowerLeft!.targetHitTotalCount

var lowerRight = Target(targetName: "Lower Right", targetHitCurrentCount: 0, targetHitTotalCount: 0)
var lowerRightHitCount = lowerRight!.targetHitCurrentCount
var llTotal = lowerRight!.targetHitTotalCount


//  move all this to its own model??
var currentDate = DateFormatter()
var newShotCycle = ShotCycle(date: "", totalPercentCalc: 0, summedShots: 0, currentShotCyclePercent: 0, summedShotsMade: 0, currentShotsMade: 0)
var totalPercentCalc = newShotCycle!.totalPercentCalc
var summedShots = newShotCycle!.summedShots
var currentShotCyclePercent = newShotCycle!.currentShotCyclePercent
var summedShotsMade = newShotCycle!.currentShotsMade
var shootingCycle = 1
var activeCycle = false



var shotCycles = [ShotCycle]()

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

