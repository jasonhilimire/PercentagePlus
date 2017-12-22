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
var targets = [ShotCycle.Target]()

class ShotCycle: Codable {
    var date: String
    var shotsTaken = sliderValue


    
    init(date: String, shotsTaken: Int){
        self.date = date
        self.shotsTaken = shotsTaken
    }
    
    func summedShots() -> Int {
        let shots = shotsTaken
        print("Shots: \(shots)")
        return shots
    }
    
    func shootingPercentage() -> Int {
        let percentCalc = (targetTotalHit() * 100) / summedShots()
        print("Shooting%: \(percentCalc)%")
        
        if percentCalc == 0 {
            return 0
        } else {
            return percentCalc
        }
        
    }
    
    class Target {
        var hitCount = 0
        var description: String
        
        init(hitCount: Int, description: String) {
            self.hitCount = hitCount
            self.description = description
        }
        
        func targetHit() -> Int {
            hitCount += 1
            print("Target Hit: \(hitCount)")
            return hitCount
        }
        
    }
    

    func targetTotalHit() -> Int {
        let totalHitCount = targets.reduce(0, {$0 + ($1.hitCount)})
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
    

    



