//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit


var activeCycle = false
var shotCycles = [ShotCycle]()


class ViewController: UIViewController {
    
    let dataModel = ShotCycleDataModel()
    var shootingCycle = 0
    var currentshotCycle = ShotCycle(date: "", shotsTaken: 0, cyclePercent: 0, shotsMade: 0, ulHitCount: 0, urHitCount: 0, blHitCount: 0, brHitCount: 0)
    
    //MARK:- SETUP
    @IBOutlet weak var calcPercentageLbl: UILabel!
    @IBOutlet weak var enteredAmtLbl: UILabel!
    @IBOutlet weak var sliderLbl: UILabel!
    @IBOutlet weak var shotsMade: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    @IBOutlet weak var incrementButtonUL: UIButton!
    @IBOutlet weak var incrementButtonUR: UIButton!
    @IBOutlet weak var incrementButtonBL: UIButton!
    @IBOutlet weak var incrementButtonBR: UIButton!
    
    @IBOutlet weak var upperLeftLabel: UILabel!
    @IBOutlet weak var upperRightLabel: UILabel!
    @IBOutlet weak var lowerLeftLabel: UILabel!
    @IBOutlet weak var lowerRightLabel: UILabel!


    //MARK:- BUTTONS
    
    // Slider Value
    @IBAction func slider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
    }

    //Upper Left Corner button pressed
    @IBAction func incrementBtnPressedUL(_ sender: UIButton) {
        buttonPressed()
        currentshotCycle?.ulHitCount += 1
        upperLeftLabel.text = "\(currentshotCycle?.ulHitCount ?? 0)"
        
}

    // Upper Right Corner button pressed
    @IBAction func incrementButtonPressedUR(_ sender: UIButton) {
        buttonPressed()
        currentshotCycle?.urHitCount += 1
        upperRightLabel.text = "\(currentshotCycle?.urHitCount ?? 0)"
        
    }
    
    // lower left corner button pressed
    @IBAction func incrementButtonPressedBL(_ sender: UIButton) {
        buttonPressed()
        currentshotCycle?.blHitCount += 1
        lowerLeftLabel.text = "\(currentshotCycle?.blHitCount ?? 0)"
        
    }
   
    // lower right corner button pressed
    @IBAction func incrementButtonPressedBR(_ sender: UIButton) {
        buttonPressed()
        currentshotCycle?.blHitCount += 1
        lowerRightLabel.text = "\(currentshotCycle?.blHitCount ?? 0)"
        
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIBarButtonItem) {
        partialScreenReset()
        resetCorners()
    }
   
    // saves current values - pressed after all shots/corners entered
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {

        saveShotCycle()
        partialScreenReset()
        resetCorners()

        print("save button pressed")
        print("ShotCycles Array Count: \(shotCycles.count)")
    }
    
    @IBAction func showSavedCyclesBtn(_ sender: Any) {

         print("show Saved button pressed")
    }
    

    
    // full delete of all Values
    @IBAction func deleteAllValues(_ sender: UIBarButtonItem) {
        fullScreenReset()
        sliderLbl.text = "Number of Shots: 15"
        sliderValue = 15
        print("delete button pressed")
    }

    //MARK:- VIEW
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
            // clear screen-reset when app is launched each time and set slider to default value of 15
        if activeCycle == false {
            var shootingCycle = 0
            fullScreenReset()
            sliderLbl.text = "Number of Shots: 15"
            sliderValue = 15
            print("viewDidLoad View Controller & .plist created")
        } else {
            partialScreenReset()
            
            print("viewDidLoad View Controller")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        activeCycle = true
        print("viewWillDisappear View Controller")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activeCycle = true
        
        
       
    }
    
    
    
    //MARK:- METHODS
    


    func saveShotCycle() {

        shootingCycle += 1

        sliderOutlet.isHidden = false


        shotsMade.text = "Total Shots Made: )"

        let date = dateFormatter()


        shotCycles.append(currentshotCycle!)
        saveData()
        
//                print("Current Shot Cycle: \(String(describing: currentShotCycle))")
    }
    
    
    // increments values in buttons and updates percent calculations
    func buttonPressed() {

        sliderOutlet.isHidden = true

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
    
    func resetCorners() {
        currentshotCycle?.ulHitCount = 0
        upperLeftLabel.text = "0"
        currentshotCycle?.urHitCount = 0
        upperRightLabel.text = "0"
        currentshotCycle?.blHitCount = 0
        lowerLeftLabel.text = "0"
        currentshotCycle?.brHitCount = 0
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

//        currentShotCyclePercent = 0
        print("partialScreenReset")
    }
    
    
    // full reset of all data values excluding slider
    func fullScreenReset() {
        partialScreenReset()
        resetCorners()
        resetValues()
        print("fullScreenReset")
    }
    
    func resetValues() {

        shotsMade.text = "Total Shots Made: 0"
        sliderOutlet.isHidden = false
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
//        summedShots = 0
//        summedShotsMade = 0
//        currentShotCyclePercent = 0
        
        resetCorners()

        print("resetValues")
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
    

    

}




