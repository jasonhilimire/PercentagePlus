//
//  ShotCycleTableViewController.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/22/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

 var shotCycles = [ShotCycle]()

class ShotCycleTableViewController: UITableViewController {


    @IBAction func save(_ sender: UIBarButtonItem) {
        saveShotCycleArray()
        print("Save button pressed: Array saved")
    }
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
      saveShotCycleArray()
        print("Back button pressed: Array saved")
    }
    
    // MARK: - Properties
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadShotCycle()
        print("View Did load & Loaded shot cycles")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shotCycles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ShotCycleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShotCycleTableViewCell else {
            fatalError("The dequed cell is not an instance of ShotCycleTableViewCell.")
        }
        
        let shotCycle = shotCycles[indexPath.row]
        let shotCycleDate = NSDate()
        cell.dateLabel.text = dateFormatter.string(from: shotCycleDate as Date)

        cell.totalShotsMadeLabel.text = "Total Shots Made: \(shotCycle.summedShotsMade)"
        cell.totalShotsTakenLabel.text = "Total Shots Taken: \(shotCycle.summedShots)"
        cell.cycleShotsMadeLabel.text =  "Cycle Shots Made : \(shotCycle.currentShotsMade)"
        cell.totalShotsPercLabel.text = "Total Shots Perc: \(shotCycle.totalPercentCalc)%"
        cell.cycleShotsPercLabel.text = "Cycle Shots Perc: \(shotCycle.currentShotCyclePercent)%"

        return cell
    }
    
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
