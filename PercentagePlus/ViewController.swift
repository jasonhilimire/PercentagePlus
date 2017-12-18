//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

let date = FormattedDate.init(date: NSDate())
let formattedDate = date?.formattedDate

class ViewController: UIViewController {

    
    let dataModel = ShotCycleDataModel()
    let currentShotCycle = ShotCycle(date: formattedDate!, shotsTaken: sliderValue)
    


    //MARK:- Target Set up
    var upperRight = ShotCycle.Target(hitCount: 0, description: "Top Right")
    var bottomRight = ShotCycle.Target(hitCount: 0, description: "Bottom Right")
    var upperLeft = ShotCycle.Target(hitCount: 0, description: "Top Left")
    var bottomLeft = ShotCycle.Target(hitCount: 0, description: "Bottom Left")
    var fiveHole = ShotCycle.Target(hitCount: 0, description: "5-hole")
    
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
        upperLeft?.targetHit()
        upperLeftLabel.text = "\(upperLeft?.hitCount)"
        
        if (upperLeft?.hitCount)! >= sliderValue {
            disableButtons()
        }
}

    // Upper Right Corner button pressed
    @IBAction func incrementButtonPressedUR(_ sender: UIButton) {
        buttonPressed()
        upperRight?.targetHit()
        upperRightLabel.text = "\(upperRight?.hitCount)"
        
        if (upperRight?.hitCount)! >= sliderValue {
            disableButtons()
        }
    }
    
    // lower left corner button pressed
    @IBAction func incrementButtonPressedBL(_ sender: UIButton) {
        buttonPressed()
        bottomLeft?.targetHit()
        lowerLeftLabel.text = "\(bottomLeft?.hitCount)"
        
        if (bottomLeft?.hitCount)! >= sliderValue {
            disableButtons()
        }
    }
   
    // lower right corner button pressed
    @IBAction func incrementButtonPressedBR(_ sender: UIButton) {
        buttonPressed()
        bottomRight?.targetHit()
        lowerRightLabel.text = "\(bottomRight?.hitCount)"
        
        if (bottomRight?.hitCount)! >= sliderValue {
            disableButtons()
        }
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIBarButtonItem) {
        partialScreenReset()
        resetCornerLabels()
    }
   
    // saves current values - pressed after all shots/corners entered
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateLabels()
        saveShotCycle()
        partialScreenReset()
        resetCornerLabels()

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
    
    func updateLabels() {
        ulShotsMadeLabel.text = "Total Shots Made Upper Left: \(upperLeft?.hitCount)"
        urShotsMadeLabel.text = "Total Shots Made Upper Right: \(upperRight?.hitCount)"
        llShotsMadeLabel.text = "Total Shots Made Lower Left: \(bottomLeft?.hitCount)"
        lrShotsMadeLabel.text = "Total Shots Made Lower Right: \(bottomRight?.hitCount)"
    }
    
    func totalShootingPercentage() {
        var totalPercentCalc = shotCycles.shootingPercentage()
        totalShootingPerc.text = "Today's Shooting Percentage: \(String(describing: totalPercentCalc))%"
    }
    
    func saveShotCycle() {

        shootingCycle += 1
        let summedShots = current
        summedShotsMade += incrementValue
        totalShotsTaken.text = "Today's Shots Taken: \(String(describing: summedShots))"
        sliderOutlet.isHidden = false
        totalShootingPercentage()
        totalShootingPerc.text = "Today's Shooting Percentage: \(String(describing: totalPercentCalc))%"
        totalShotsMade.text = "Total Shots Made: \(String(describing: summedShotsMade))"

//        let date = dateFormatter()
//        let currentShotCycle = ShotCycle(date: date, totalPercentCalc: totalPercentCalc, summedShots: summedShots, currentShotCyclePercent: currentShotCyclePercent, summedShotsMade: summedShotsMade, currentShotsMade: incrementValue, shotsTaken: sliderValue)

        shotCycles.append(currentShotCycle!)
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
        upperLeft?.hitCount = 0
        upperLeftLabel.text = "0"
        upperRight?.hitCount = 0
        upperRightLabel.text = "0"
        bottomLeft?.hitCount = 0
        lowerLeftLabel.text = "0"
        bottomRight?.hitCount = 0
        lowerRightLabel.text = "0"
        print("resetCornerLabels")
    }

    
    func partialScreenReset(action: UIAlertAction! = nil) {
        enableButtons()
        calcPercentageLbl.text = "0%"
        enteredAmtLbl.text = "Use Slider to Enter Count"
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        sliderOutlet.isHidden = false
        enteredAmtLbl.text = "Use Slider to Enter Shot Count"
        incrementValue = 0
        currentShotCyclePercent = 0
        print("partialScreenReset")
    }
    
    
    // full reset of all data values excluding slider
    func fullScreenReset() {
        partialScreenReset()
        resetCornerLabels()
        resetValues()
        print("fullScreenReset")
    }
    
    func resetValues() {
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
        print("resetValues")
    }
    
    func keepTSMLabelsIntact() {
        // Keep the total shots made labels intact, for when returning from Shot Cycles View
        // TODO: the shotsMadeLabels are not being updated when returning from the tableView as they are not saved anywhere
        ulShotsMadeLabel.text = "Total Shots Made Upper Left: \(ulTotal)"
        urShotsMadeLabel.text = "Total Shots Made Upper Right: \(urTotal)"
        llShotsMadeLabel.text = "Total Shots Made Lower Left: \(llTotal)"
        lrShotsMadeLabel.text = "Total Shots Made Lower Right: \(lrTotal)"
        
        
        totalShootingPerc.text = "Today's Shooting Percentage: \(totalPercentCalc)%"
        totalShotsTaken.text = "Today's Shots Taken: \(summedShots)"
        totalShotsMade.text = "Total Shots Made: \(summedShotsMade)"
        print("keepTSMLabelsIntact()")
        
    }
    
    func saveData() {
        dataModel.saveShotCycleArray()
        print("ShotcyclesArray saved")
        print("Documents folder is \(dataModel.documentsDirectory())")
        print("Data file path is \(dataModel.dataFilePath())")
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
        
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        activeCycle = true
        print("viewWillDisappear View Controller")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activeCycle = true
        keepTSMLabelsIntact()

//        print("viewWillAppear: summedShots = \(summedShots), totalPercentCalc = \(totalPercentCalc), summedShotsMade = \(summedShotsMade), currentShotCyclePercent = \(currentShotCyclePercent)")
    }
    

}




