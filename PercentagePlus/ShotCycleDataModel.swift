//
//  ShotCycleDataModel.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/10/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

class ShotCycleDataModel {
    var shotCycle = [ShotCycle]()
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("PercentagePlus.plist")
    }
    
    func saveShotCycleArray() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(shotCycles)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print(" Error encoding shotCycles array")
        }
        
    }
    
    func loadShotCycle() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                shotCycles = try decoder.decode([ShotCycle].self, from: data)
            } catch {
                print("Error shotCycles item array!")
            }
        }
    }
    
}
