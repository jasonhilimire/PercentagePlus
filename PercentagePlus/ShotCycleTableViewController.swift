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
    let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView

    @IBAction func deleteAllArray(_ sender: UIBarButtonItem) {
       
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        // ...
    }
    
    // MARK: - VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.delegate = (self as! UINavigationControllerDelegate)
//        let shotCycle = dataModel.shotCycle
//        performSegue(withIdentifier: "ShowShotCycles", sender: shotCycle)
        

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
    

    
    func loadData() {
        dataModel.loadShotCycle()
        print("ShotcyclesArray Loaded")
    }
    
    func saveData() {
         dataModel.saveShotCycleArray()
        print("ShotcyclesArray Saved")
    }
    

    }
    


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
