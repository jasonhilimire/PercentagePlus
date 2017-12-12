//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

var sliderValue: Int = 0
var incrementValue: Int = 0

//MARK:- Target Set up
var upperRight = Target(targetName: "Upper Right", targetHitCurrentCount: 0, targetHitTotalCount: 0)
var upperRightHitCount = upperRight!.targetHitCurrentCount
var urTotal = upperRight!.targetHitTotalCount

var upperLeft = Target(targetName: "Upper Left" , targetHitCurrentCount: 0, targetHitTotalCount: 0)
var upperLeftHitCount = upperLeft!.targetHitCurrentCount
var ulTotal = upperLeft!.targetHitTotalCount

var lowerLeft = Target(targetName: "Lower Left", targetHitCurrentCount: 0, targetHitTotalCount: 0)
var lowerLeftHitCount = lowerLeft!.targetHitCurrentCount
var lrTotal = lowerLeft!.targetHitTotalCount

var lowerRight = Target(targetName: "Lower Right", targetHitCurrentCount: 0, targetHitTotalCount: 0)
var lowerRightHitCount = lowerRight!.targetHitCurrentCount
var llTotal = lowerRight!.targetHitTotalCount


//  move all this to its own model??
var currentDate = DateFormatter()
var newShotCycle = ShotCycle(date: "", totalPercentCalc: 0, summedShots: 0, currentShotCyclePercent: 0, summedShotsMade: 0, currentShotsMade: 0)
var totalPercentCalc = newShotCycle!.totalPercentCalc
var summedShots = newShotCycle!.summedShots
var currentShotCyclePercent = newShotCycle!.currentShotCyclePercent
var summedShotsMade = newShotCycle!.currentShotsMade
var shootingCycle = 1
var activeCycle = false


//protocol UIViewControllerDelegate: class {
//    func uiViewControllerDelegate(_ controller: UIViewController, didPressSave: ShotCycle)
//}


class ViewController: UIViewController {
//        let dataModel = ShotCycleDataModel()
    
//    weak var delegate: UIViewControllerDelegate?

    
    //MARK:- SETUP
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

    //MARK:- BUTTONS
    
    // Slider Value
    @IBAction func slider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
    }

    //Upper Left Corner button pressed
    @IBAction func incrementBtnPressedUL(_ sender: UIButton) {
        buttonPressed()
        upperLeftHitCount += 1
        upperLeftLabel.text = "\(upperLeftHitCount)"
        
        if upperLeftHitCount >= sliderValue {
            disableButtons()
        }
}

    // Upper Right Corner button pressed
    @IBAction func incrementButtonPressedUR(_ sender: UIButton) {
        buttonPressed()
        upperRightHitCount += 1
        upperRightLabel.text = "\(upperRightHitCount)"
        
        if upperRightHitCount >= sliderValue {
            disableButtons()
        }
    }
    
    // lower left corner button pressed
    @IBAction func incrementButtonPressedBL(_ sender: UIButton) {
        buttonPressed()
        lowerLeftHitCount += 1
        lowerLeftLabel.text = "\(lowerLeftHitCount)"
        
        if lowerLeftHitCount >= sliderValue {
            disableButtons()
        }
    }
   
    // lower right corner button pressed
    @IBAction func incrementButtonPressedBR(_ sender: UIButton) {
        buttonPressed()
        lowerRightHitCount += 1
        lowerRightLabel.text = "\(lowerRightHitCount)"
        
        if lowerRightHitCount >= sliderValue {
            disableButtons()
        }
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIBarButtonItem) {
        partialScreenReset()
    }
   
    // saves current values - pressed after all shots/corners entered
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        saveShotCycle()
        calculateTotals()
        partialScreenReset()

        print("save button pressed")
        print("ShotCycles Array Count: \(shotCycles.count)")
    }
    
    @IBAction func showSavedCyclesBtn(_ sender: Any) {
        saveShotCycle()
         print("show Saved button pressed")
    }
    

    
    // full delete of all Values
    @IBAction func deleteAllValues(_ sender: UIBarButtonItem) {
        fullScreenReset()
        sliderLbl.text = "Number of Shots: 15"
        sliderValue = 15
        print("delete button pressed")
    }

    //MARK:- METHODS
    
    func calculateTotals() {
        ulTotal += upperLeftHitCount
        ulShotsMadeLabel.text = "Total Shots Made Upper Left: \(ulTotal)"
        
        urTotal += upperRightHitCount
        urShotsMadeLabel.text = "Total Shots Made Upper Right: \(urTotal)"
        
        llTotal += lowerLeftHitCount
        llShotsMadeLabel.text = "Total Shots Made Lower Left: \(llTotal)"
        
        lrTotal += lowerRightHitCount
        lrShotsMadeLabel.text = "Total Shots Made Lower Right: \(lrTotal)"
    }
    
    func totalShootingPercentage() {
        totalPercentCalc = ((summedShotsMade * 100) / summedShots)
        totalShootingPerc.text = "Today's Shooting Percentage: \(String(describing: totalPercentCalc))%"
    }
    
    func saveShotCycle() {

        shootingCycle += 1
        summedShots += sliderValue
        summedShotsMade += incrementValue
        totalShotsTaken.text = "Today's Shots Taken: \(String(describing: summedShots))"
        sliderOutlet.isHidden = false
        totalShootingPercentage()
        totalShootingPerc.text = "Today's Shooting Percentage: \(String(describing: totalPercentCalc))%"
        totalShotsMade.text = "Total Shots Made: \(String(describing: summedShotsMade))"

        let date = dateFormatter()
        let currentShotCycle = ShotCycle(date: date, totalPercentCalc: totalPercentCalc, summedShots: summedShots, currentShotCyclePercent: currentShotCyclePercent, summedShotsMade: summedShotsMade, currentShotsMade: incrementValue)

        shotCycles.append(currentShotCycle!)
                // when run sends the currentShotCycle back to the delegate
        delegate?.uiViewControllerDelegate(self, didPressSave: currentShotCycle!)
        saveData()
        
                print("Current Shot Cycle: \(String(describing: currentShotCycle))")
    }
    
    
    // increments values in buttons and updates percent calculations
    func buttonPressed() {
        incrementValue += 1
        sliderOutlet.isHidden = true

        if incrementValue > sliderValue {
            disableButtons()
        } else {
            currentShotCyclePercent = ((incrementValue * 100) / sliderValue)
            self.calcPercentageLbl.text = "\(Int(currentShotCyclePercent))%"
            self.enteredAmtLbl.text = "Shots Made this Cycle: \(Int(incrementValue))"
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
        upperLeftHitCount = 0
        upperLeftLabel.text = "0"
        upperRightHitCount = 0
        upperRightLabel.text = "0"
        lowerLeftHitCount = 0
        lowerLeftLabel.text = "0"
        lowerRightHitCount = 0
        lowerRightLabel.text = "0"
    }
    
    // only resets the 4 corners and current data values- does not reset saved data values or slider
    func partialScreenReset(action: UIAlertAction! = nil) {
        enableButtons()
        calcPercentageLbl.text = "0%"
        enteredAmtLbl.text = "Use Slider to Enter Count"
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        sliderOutlet.isHidden = false
        enteredAmtLbl.text = "Use Slider to Enter Shot Count"
        incrementValue = 0
        resetCornerLabels()
        currentShotCyclePercent = 0
        
    }
    
    
    // full reset of all data values excluding slider
    func fullScreenReset() {
        partialScreenReset()
        totalShotsTaken.text = "Today's Shots Taken: 0"
        totalShootingPerc.text = "Today's Shooting Percentage: 0%"
        totalShotsMade.text = "Total Shots Made: 0"
        sliderOutlet.isHidden = false
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        summedShots = 0
        summedShotsMade = 0
        currentShotCyclePercent = 0
        
        ulTotal = 0
        ulShotsMadeLabel.text = "Total Shots Made Upper Left: 0"
        
        urTotal = 0
        urShotsMadeLabel.text = "Total Shots Made Upper Right: 0"
        
        llTotal = 0
        llShotsMadeLabel.text = "Total Shots Made Lower Left: 0"
        
        lrTotal = 0
        lrShotsMadeLabel.text = "Total Shots Made Lower Right: 0"
    }
    
    func keepTSMLabelsIntact() {
        // Keep the total shots made labels intact, for when returning from Shot Cycles View
        ulShotsMadeLabel.text = "Total Shots Made Upper Left: \(ulTotal)"
        urShotsMadeLabel.text = "Total Shots Made Upper Right: \(urTotal)"
        llShotsMadeLabel.text = "Total Shots Made Lower Left: \(llTotal)"
        lrShotsMadeLabel.text = "Total Shots Made Lower Right: \(lrTotal)"
        totalShootingPerc.text = "Today's Shooting Percentage: \(totalPercentCalc)%"
        totalShotsTaken.text = "Today's Shots Taken: \(summedShots)"
        totalShotsMade.text = "Total Shots Made: \(summedShotsMade)"
        
    }
    
    func saveData() {
        dataModel.saveShotCycleArray()
        print("ShotcyclesArray saved")
//        print("Documents folder is \(dataModel.documentsDirectory())")
//        print("Data file path is \(dataModel.dataFilePath())")
    }
    
    func dateFormatter() -> String{
        let currentDate = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        let dateString = formatter.string(from: currentDate as Date)
        print("\(dateString)")
        return dateString
 
    }
    
    //MARK:- VIEW
    
    // clear screen-reset when app is launched each time and set slider to default value of 15
    override func viewDidLoad() {
        super.viewDidLoad()
        if activeCycle == false {
        fullScreenReset()
        sliderLbl.text = "Number of Shots: 15"
        sliderValue = 15
        print("viewDidLoad View Controller & .plist created ")
        } else {
            partialScreenReset()
            keepTSMLabelsIntact()
             print("viewDidLoad View Controller")
        }
//        saveData()
//        dataModel.loadShotCycle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        activeCycle = true
        print("viewWillDisappear View Controller")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activeCycle = true

        print("viewWillAppear: summedShots = \(summedShots), totalPercentCalc = \(totalPercentCalc), summedShotsMade = \(summedShotsMade), currentShotCyclePercent = \(currentShotCyclePercent)")
    }
    

}



// first go at adding UIActionAlert Controller & it works!! using a switch case successfully this goes in save()
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
