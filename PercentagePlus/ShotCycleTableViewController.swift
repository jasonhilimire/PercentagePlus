//
//  ShotCycleTableViewController.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/22/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit
import CoreData

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

class ShotCycleTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<ShotCycle>!
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    var shotCycle = ShotCycle(context: context)

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
            
            self.deleteAllRecords()
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
        
        attemptFetch()
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
        
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ShotCycleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShotCycleTableViewCell else {
            fatalError("The dequed cell is not an instance of ShotCycleTableViewCell.")
        }
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)

        return cell
    }
    
    func configureCell(cell: ShotCycleTableViewCell, indexPath: NSIndexPath) {
        let shotCycle = controller.object(at: indexPath as IndexPath)
        cell.configureCell(shotCycle: shotCycle)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // remove the item at its indexpath
        context.delete(shotCycle)
        ad.saveContext()
        lifetimeLabels()
        tableView.reloadData()
        // TODO: also do a full screen reset - may need to create a delegate?
        
    }
    
    //MARK:- HEADERVIEW
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 103
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerViewSetup()
        
        return headerView
    }
    
    //MARK:- METHODS
   
    
    func lifetimeLabels() {
//        headerView.totalShotsTaken.text = ("Total Shots taken: \(lifetime.lifeTimeShotsTaken())")
//        headerView.totalShotsMade.text = "Shots Made: \(lifetime.lifeTimeShotsMade())"
//        headerView.totalShotPerc.text = "Shooting Percentage: \(lifetime.lifeTimeShootingPerc())%"
//        headerView.totalShotCycles.text = "Lifetime Shooting Cycles: \(lifetime.lifeTimeShotCycles())"

    }
    
    func headerViewSetup() {
        headerView.vw?.layer.cornerRadius = 15

        // border
        headerView.vw?.layer.borderWidth = 2
        headerView.vw?.layer.borderColor = UIColor.black.cgColor
        // shadow- 
        headerView.vw.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)

    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<ShotCycle> = ShotCycle.fetchRequest()
        
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            
            try controller.performFetch()
            print("Fetch Performed")
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ShotCycleTableViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
            
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ShotCycle")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
