//
//  ShotCycleDataModel.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/10/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Foundation

class ShotCycleDataModel {


    
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
                sortData()
            } catch {
                print("Error shotCycles item array!")
            }
        }
    }
    
    func deleteDataFile() {
        let path = dataFilePath()
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print("Error no file to delete!")
        }
    }
    

    func sortData() {
        // sorts array by date so earliest date shows first when loading in ShotCycleViewController
        shotCycles.sort(by: {$0.date < $1.date})
    }

    
    init () {
        loadShotCycle()
    }
    
}
