//
//  ShotCycle.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

var sliderValue: Int = 0
var incrementValue: Int = 0
var activeCycle = false
var shootingCycle = 0

var shotCycles = [ShotCycle]()


class ShotCycles {
    var date: String
    var shotsTaken: Int
    var shots = 0
    
    var targets = [Target]()
    var upperleft = Target(hitCount: 0, description: "Top Left")
    var bottomRight = Target(hitCount: 0, description: "Bottom Right")
    var bottomLeft = Target(hitCount: 0, description: "Bottom Left")
    var topRight = Target(hitCount: 0, description: "Top Right")
    var fiveHole = Target(hitCount: 0, description: "5-Hole")
    
    init?(date: String, shotsTaken: Int){
        self.date = date
        self.shotsTaken = shotsTaken
    }
    
    func summedShots() -> Int {
        shotsTaken = shots
        print("Shots: \(shotsTaken)")
        return shotsTaken
    }
    
    func shootingPercentage() -> Int {
        let percentCalc = (targetTotalHit() * 100) / shotsTaken
        print("Shots: \(shotsTaken)")
        print("Shooting%: \(percentCalc)%")
        return percentCalc
        
    }
    
    class Target {
        
        var hitCount = 0
        var description = ""
        
        init?(hitCount: Int, description: String) {
            self.hitCount = hitCount
            self.description = description
        }
        
        func targetHit() -> Int {
            hitCount += 1
            print("Targets Hit: \(hitCount)")
            return hitCount
        }
        
    }
    
    func targetTotalHit() -> Int {
        let totalHitCount = targets.reduce(0, {$0 + ($1.hitCount)})
        print("Total Hit count: \(totalHitCount)")
        return totalHitCount
    }
    

    func dateFormatter() -> String{
        let currentDate = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        let dateString = formatter.string(from: currentDate as Date)
        print("\(dateString)")
        return dateString
        
    }
    
}

    

    



