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
    
    let impactHaptic = UIImpactFeedbackGenerator()
    let selectionHaptic = UISelectionFeedbackGenerator()
    let notificationHaptic = UINotificationFeedbackGenerator()


    @IBAction func deleteAllBtn(_ sender: UIBarButtonItem) {
        
        notificationHaptic.notificationOccurred(.error)
        // deletes the array and the .plist file
        let alertController = UIAlertController(title: "Warning!", message: "This will DELETE all your Shot Cycles data!! This cannot be undone", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.impactHaptic.impactOccurred()
        }
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.impactHaptic.impactOccurred()
            self.dataModel.deleteDataFile()
            shotCycles.removeAll()
            self.lifetimeLabels()
            NotificationCenter.default.post(name: Notification.Name(rawValue: notification), object: self)
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
        
        // listen for notification sent from savedButtonPressed
        NotificationCenter.default.addObserver(self, selector: #selector(ShotCycleTableViewController.actOnNotification), name: NSNotification.Name(rawValue: notification), object: nil)
        loadData()
        lifetimeLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        // func to occur when notification is sent
    @objc func actOnNotification() {
        tableView.reloadData()
        lifetimeLabels()
    }
    
    // MARK: - TABLEVIEW
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shotCycles.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ShotCycleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShotCycleTableViewCell else {
            fatalError("The dequed cell is not an instance of ShotCycleTableViewCell.")
        }
        
        let shotCycle = shotCycles[indexPath.row]
        cell.dateLabel.text = "\(shotCycle.date)"

        cell.shotsMadeLabel.text = "Shots Made: \(shotCycle.shotsMade)"
        cell.shotsTakenLabel.text = "Shots: \(shotCycle.shotsTaken)"
        cell.shotsPercLabel?.text = "Perc: \(shotCycle.cyclePercent)%"

        cell.ulLabel.text = "TL: \(shotCycle.ulHitCount)"
        cell.urLabel.text = "TR: \(shotCycle.urHitCount)"
        cell.blLabel.text = "BL: \(shotCycle.blHitCount)"
        cell.brLabel.text = "BR: \(shotCycle.brHitCount)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // remove the item at its indexpath
        impactHaptic.impactOccurred()
        shotCycles.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: notification), object: self)
        lifetimeLabels()
        saveData()
        
    }
    
    //MARK:- HEADERVIEW
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 160
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerViewSetup()
        
        return headerView
    }
    
    //MARK:- METHODS
    

    func loadData() {
        dataModel.loadShotCycle()
    }
    
    func saveData() {
        dataModel.saveShotCycleArray()
    }
    
    func lifetimeLabels() {
        headerView.totalShotsTaken.text = ("Shots taken: \(lifetime.lifeTimeShotsTaken())")
        headerView.totalShotsMade.text = "Made: \(lifetime.lifeTimeShotsMade())"
        headerView.totalShotPerc.text = "Percent: \(lifetime.lifeTimeShootingPerc())%"
        headerView.totalShotCycles.text = "Cycles: \(lifetime.lifeTimeShotCycles())"
        headerView.ulMade.text = "Top Left: \(lifetime.lifeTimeUL())"
        headerView.urMade.text = "Top Right: \(lifetime.lifeTimeUR())"
        headerView.blMade.text = "Bott Left: \(lifetime.lifeTimeBL())"
        headerView.brMade.text = "Bott Right: \(lifetime.lifeTimeBR())"

    }
    
    func headerViewSetup() {
        headerView.vw?.layer.cornerRadius = 15

        // border
        headerView.vw?.layer.borderWidth = 2
        headerView.vw?.layer.borderColor = UIColor.black.cgColor
        // shadow- 
        headerView.vw.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)

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

