//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Properties
var sliderValue: Int = 0
var incrementValue: Int = 0
var upperRight: Int = 0
var upperLeft: Int = 0
var lowerLeft: Int = 0
var lowerRight: Int = 0
var totalPercentCalc = 0
var summedShots = 0
var summedPercentCalc = 0
var summedShootingCycle = 1
var summedShotsMade = 0
var ulTotal = 0
var urTotal = 0
var llTotal = 0
var lrTotal = 0






class ViewController: UIViewController, UITableViewDelegate {
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    // holds the managed object context for core data
    var managedContext: NSManagedObjectContext!
    
    var currentShooter: Shooter?
    
   

// MARK: - IBActions
    @IBOutlet weak var calcPercentageLbl: UILabel!
    @IBOutlet weak var enteredAmtLbl: UILabel!
    @IBOutlet weak var sliderLbl: UILabel!
    @IBOutlet weak var incrementButtonUL: UIButton!

    @IBOutlet weak var incrementButtonUR: UIButton!
    @IBOutlet weak var incrementButtonBL: UIButton!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var incrementButtonBR: UIButton!
    @IBOutlet weak var upperLeftLabel: UILabel!
    @IBOutlet weak var upperRightLabel: UILabel!
    @IBOutlet weak var lowerLeftLabel: UILabel!
    @IBOutlet weak var lowerRightLabel: UILabel!

    @IBOutlet weak var totalShootingPerc: UILabel!
    @IBOutlet weak var totalShotsTaken: UILabel!
    @IBOutlet weak var totalShotsMade: UILabel!
    
    @IBOutlet weak var ulShotsMadeLabel: UILabel!
    @IBOutlet weak var urShotsMadeLabel: UILabel!
    @IBOutlet weak var llShotsMadeLabel: UILabel!
    @IBOutlet weak var lrShotsMadeLabel: UILabel!
    
    
    
    
    // Slider Value
    @IBAction func slider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
    }

    //Upper Left Corner button pressed
    @IBAction func incrementBtnPressedUL(_ sender: UIButton) {
        buttonPressed()
        upperLeft += 1
        upperLeftLabel.text = "\(upperLeft)"
        
        if upperLeft >= sliderValue {
            disableButtons()
        }
}

    // Upper Right Corner button pressed
    @IBAction func incrementButtonPressedUR(_ sender: UIButton) {
        buttonPressed()
        upperRight += 1
        upperRightLabel.text = "\(upperRight)"
        
        if upperRight >= sliderValue {
            disableButtons()
        }
    }
    
    // lower left corner button pressed
    @IBAction func incrementButtonPressedBL(_ sender: UIButton) {
        buttonPressed()
        lowerLeft += 1
        lowerLeftLabel.text = "\(lowerLeft)"
        
        if lowerLeft >= sliderValue {
            disableButtons()
        }
    }
   
    // lower right corner button pressed
    @IBAction func incrementButtonPressedBR(_ sender: UIButton) {
        buttonPressed()
        lowerRight += 1
        lowerRightLabel.text = "\(lowerRight)"
        
        if lowerRight >= sliderValue {
            disableButtons()
        }
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIBarButtonItem) {
        partialScreenReset()
    }
   
    // saves current values - pressed after all shots/corners entered
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        summedShootingCycle += 1
        summedShots += sliderValue
        summedShotsMade += incrementValue
        totalShotsTaken.text = "Today's Shots Taken: \(summedShots)"
        sliderOutlet.isHidden = false
        totalShootingPercentage()
        
        totalShotsMade.text = "Total Shots Made: \(summedShotsMade)"
        
        calculateTotals()
        
        
        // first go at adding UIActionAlert Controller & it works!! using a switch case successfully
//        switch incrementValue {
//        case 0:
//            let ac = UIAlertController(title: title, message: "Hopefully you at least hit a post! this is just a warmup right?", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Shoot Again", style: .default, handler: partialScreenReset))
//            present(ac, animated: true)
//
//        case 1..<5:
//            let ac = UIAlertController(title: title, message: "Heating Up, Let's Keep going for more!", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Shoot Again", style: .default, handler: partialScreenReset))
//            present(ac, animated: true)
//
//        case 5..<10:
//            let ac = UIAlertController(title: title, message: "Nice Shooting Bud! A few of those will get by the tendy for sure", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Shoot Again", style: .default, handler: partialScreenReset))
//            present(ac, animated: true)
//
//        case 10..<100:
//            let ac = UIAlertController(title: title, message: "Dangle, Snipe, Celly: On fire!! (You might wanna move farther away next round)", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Shoot Again", style: .default, handler: partialScreenReset))
//            present(ac, animated: true)
//
//        default:
//            let ac = UIAlertController(title: title, message: "Keep at it, Can't score if you don't shoot!", preferredStyle: .alert)
//             ac.addAction(UIAlertAction(title: "Shoot Again", style: .default, handler: partialScreenReset))
//             present(ac, animated: true)
//        }
        
        partialScreenReset()
    }
    
    
    func calculateTotals() {
        ulTotal += upperLeft
        ulShotsMadeLabel.text = "Total Shots Made Upper Left: \(ulTotal)"
        
        urTotal += upperRight
        urShotsMadeLabel.text = "Total Shots Made Upper Right: \(urTotal)"
        
        llTotal += lowerLeft
        llShotsMadeLabel.text = "Total Shots Made Lower Left: \(llTotal)"
        
        lrTotal += lowerRight
        lrShotsMadeLabel.text = "Total Shots Made Lower Right: \(lrTotal)"
    }
    
    // full delete of all Values
    @IBAction func deleteAllValues(_ sender: UIBarButtonItem) {
        fullScreenReset()
    }

    func totalShootingPercentage( ) {
        summedPercentCalc = ((summedShotsMade * 100) / summedShots)
        totalShootingPerc.text = "Today's Shooting Percentage: \(summedPercentCalc)%"
    }
    
    
    // increments values in buttons and updates percent calculations
    func buttonPressed() {
        incrementValue += 1
        sliderOutlet.isHidden = true

        if incrementValue > sliderValue {
            disableButtons()
        } else {
            totalPercentCalc = ((incrementValue * 100) / sliderValue)
            self.calcPercentageLbl.text = "\(Int(totalPercentCalc))%"
            self.enteredAmtLbl.text = "Shots Made this Cycle: \(Int(incrementValue))"
//            print(incrementValue, totalPercentCalc)
        }
    }
    
    func enableButtons() {
        incrementButtonUL.isEnabled = true
        incrementButtonBL.isEnabled = true
        incrementButtonBR.isEnabled = true
        incrementButtonUR.isEnabled = true
    }
    
    func disableButtons() {
        incrementButtonUL.isEnabled = false
        incrementButtonBL.isEnabled = false
        incrementButtonBR.isEnabled = false
        incrementButtonUR.isEnabled = false
    }
    
    func resetCornerLabels() {
        upperLeft = 0
        upperLeftLabel.text = "0"
        upperRight = 0
        upperRightLabel.text = "0"
        lowerLeft = 0
        lowerLeftLabel.text = "0"
        lowerRight = 0
        lowerRightLabel.text = "0"
    }
    
    // only resets the 4 corners and current data values- does not reset saved data values or slider
    func partialScreenReset(action: UIAlertAction! = nil) {
        enableButtons()
        calcPercentageLbl.text = "0%"
//        sliderValue = 15
        enteredAmtLbl.text = "Use Slider to Enter Count"
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        sliderOutlet.isHidden = false
        enteredAmtLbl.text = "Use Slider to Enter Shot Count"
        incrementValue = 0
        resetCornerLabels()
        
    }
    
    
    // full reset of all data values excluding slider
    func fullScreenReset() {
        partialScreenReset()
        totalShotsTaken.text = "Today's Shots Taken: 0"
        totalShootingPerc.text = "Today's Shooting Percentage: 0%"
        totalShotsMade.text = "Total Shots Made: 0"
        sliderOutlet.isHidden = false
//        sliderValue = 15
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        summedShots = 0
        summedShotsMade = 0
        summedPercentCalc = 0
        
        ulTotal = 0
        ulShotsMadeLabel.text = "Total Shots Made Upper Left: 0"
        
        urTotal = 0
        urShotsMadeLabel.text = "Total Shots Made Upper Right: 0"
        
        llTotal = 0
        llShotsMadeLabel.text = "Total Shots Made Lower Left: 0"
        
        lrTotal = 0
        lrShotsMadeLabel.text = "Total Shots Made Lower Right: 0"
    }
    
    // clear screen-reset when app is launched each time and set slider to default value of 15
    override func viewDidLoad() {
        fullScreenReset()
        sliderLbl.text = "Number of Shots: 15"
        sliderValue = 15
        
        let shooterName = "Shooter 1"
        let shooterFetch: NSFetchRequest<Shooter> = Shooter.fetchRequest()
        shooterFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Shooter.name), shooterName)
        
        do {
            let results = try managedContext.fetch(shooterFetch)
            if results.count > 0 {
                // Shooter 1 found // user shooter 1
                currentShooter = results.first
            } else {
                //Fide not found , create fido
                currentShooter = Shooter(context: managedContext)
                currentShooter?.name = shooterName
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description \(error.userInfo)")
        }
    }
}
