//
//  ShotCycleTableViewController.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/22/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit
import CoreData



class ShotCycleTableViewController: UITableViewController {
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    // holds the managed object context for core data
    var managedContext: NSManagedObjectContext!
    
    var currentShooter: Shooter?

    override func viewDidLoad() {
        super.viewDidLoad()
        let shooterName = "Shooter 1"
        let shooterFetch: NSFetchRequest<Shooter> = Shooter.fetchRequest()
        shooterFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Shooter.name), shooterName)
        
        do {
            let results = try managedContext.fetch(shooterFetch)
            if results.count > 0 {
                // Shooter 1 found // user shooter 1
                currentShooter = results.first
            } else {
                //Shooter not found , create Shooter
                currentShooter = Shooter(context: managedContext)
                currentShooter?.name = shooterName
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description \(error.userInfo)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let shotCycles = currentShooter?.shotCycles else {
            return 1
        }
        return shotCycles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ShotCycleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShotCycleTableViewCell else {
            fatalError("The dequed cell is not an instance of ShotCycleTableViewCell.")
        }
        
        guard let cycle = currentShooter?.shotCycles?[indexPath.row] as? ShotCycle,
            let cycleDate = cycle.date as? Date else {
                return cell
        }

        cell.dateLabel.text = dateFormatter.string(from: cycleDate)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
