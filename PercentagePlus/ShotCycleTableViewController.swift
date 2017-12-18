//
//  ShotCycleTableViewController.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/22/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

class ShotCycleTableViewController: UITableViewController {

    let dataModel = ShotCycleDataModel()
    let lifetime = LifetimeShotCycle()

    @IBOutlet weak var lifetimeShotsTaken: UILabel!
    @IBOutlet weak var lifetimeShotsMade: UILabel!
    @IBOutlet weak var lifetimeShotPerc: UILabel!
    


    @IBAction func deleteAllBtn(_ sender: UIBarButtonItem) {
        // deletes the array and the .plist file
        let alertController = UIAlertController(title: "Warning!", message: "This will DELETE all your Shot Cycles data!! This cannot be undone", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Cancel button pressed")
        }
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.dataModel.deleteDataFile()
            shotCycles.removeAll()
            print("Delete button pressed: Array deleted")
            self.tableView.reloadData()
        }
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
       
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {

    }
    
    // MARK: - VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
//        lifetimeLabels()
        print("View Did load - ShotCycleTableView")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TABLEVIEW
    
    
    
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
        cell.dateLabel.text = "\(shotCycle.date)"

        cell.totalShotsMadeLabel.text = "Total Shots Made: \(shotCycle.summedShotsMade)"
        cell.totalShotsTakenLabel.text = "Total Shots Taken: \(shotCycle.summedShots)"
        cell.cycleShotsMadeLabel.text =  "Cycle Shots Made : \(shotCycle.currentShotsMade)"
        cell.totalShotsPercLabel.text = "Total Shots Perc: \(shotCycle.totalPercentCalc)%"
        cell.cycleShotsPercLabel.text = "Cycle Shots Perc: \(shotCycle.currentShotCyclePercent)%"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // remove the item at its indexpath
        shotCycles.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
//        lifetimeLabels()
        // TODO: also do a full screen reset - may need to create a delegate?
        saveData()
        
    }
    
    //MARK:- HEADERVIEW
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 100
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        
        headerView.totalShotsMade.text = ("Total Shots taken: \(lifetime.lifeTimeShotsTaken())")
        
        return headerView
    }
    
    //MARK:- METHODS
    func loadData() {
        dataModel.loadShotCycle()
        print("ShotcyclesArray Loaded")
    }
    
    func saveData() {
        dataModel.saveShotCycleArray()
        print("ShotcyclesArray Saved")
    }
    
//    func lifetimeLabels() {
//        lifetimeShotsTaken.text = "Shots Taken: \(lifetime.lifeTimeShotsTaken())"
//        lifetimeShotsMade.text = "Shots Made: \(lifetime.lifeTimeShotsMade())"
//        lifetimeShotPerc.text = "Shooting Percentage: \(lifetime.lifeTimeShootingPerc())"
//    }
    

}
