//
//  ShotCycleTableViewController.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/22/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

class ShotCycleTableViewController: UITableViewController {

    let dataModel = ShotCycleDataModel()
    let lifetime = LifetimeShotCycle()
    let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView


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
            self.lifetimeLabels()
            print("Delete button pressed: Array deleted")
            self.tableView.reloadData()
        }
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
       
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        // ...
    }
    
    // MARK: - VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        lifetimeLabels()
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
        lifetimeLabels()
        // TODO: also do a full screen reset - may need to create a delegate?
        saveData()
        
    }
    
    //MARK:- HEADERVIEW
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 115
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerViewSetup()
        
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
    
    func lifetimeLabels() {
        headerView.totalShotsTaken.text = ("Total Shots taken: \(lifetime.lifeTimeShotsTaken())")
        headerView.totalShotsMade.text = "Shots Made: \(lifetime.lifeTimeShotsMade())"
        headerView.totalShotPerc.text = "Shooting Percentage: \(lifetime.lifeTimeShootingPerc())%"
        headerView.totalShotCycles.text = "Lifetime Shooting Cycles: \(lifetime.lifeTimeShotCycles())"

    }
    
    func headerViewSetup() {
        headerView.vw?.layer.cornerRadius = 15

        // border
        headerView.vw?.layer.borderWidth = 2
        headerView.vw?.layer.borderColor = UIColor.black.cgColor
        // shadow- not getting this offset properly
        headerView.vw.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)

    }
    

    

}
