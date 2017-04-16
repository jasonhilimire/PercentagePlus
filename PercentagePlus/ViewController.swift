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
var upperRight: Int = 0
var upperLeft: Int = 0
var lowerLeft: Int = 0
var lowerRight: Int = 0
var totalPercentCalc = 0
var summedShots = 0
var summedPercentCalc = 0
var summedShootingCycle = 1
var summedShotsMade = 0




class ViewController: UIViewController {

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
    
    
    
    
    @IBAction func slider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        
    }

    
    @IBAction func incrementBtnPressedUL(_ sender: UIButton) {
        buttonPressed()
        upperLeft += 1
        upperLeftLabel.text = "\(upperLeft)"
}

    @IBAction func incrementButtonPressedUR(_ sender: UIButton) {
        buttonPressed()
        upperRight += 1
        upperRightLabel.text = "\(upperRight)"
    }
    
    
    @IBAction func incrementButtonPressedBL(_ sender: UIButton) {
        buttonPressed()
        lowerLeft += 1
        lowerLeftLabel.text = "\(lowerLeft)"
    }
   
    @IBAction func incrementButtonPressedBR(_ sender: UIButton) {
        buttonPressed()
        lowerRight += 1
        lowerRightLabel.text = "\(lowerRight)"
    }
    
    

    @IBAction func resetButtonPressed(_ sender: UIBarButtonItem) {
        partialScreenReset()
    }
   

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        summedShootingCycle += 1
        summedShots += sliderValue
        totalShotsTaken.text = "Today's Shots Taken: \(summedShots)"
        sliderOutlet.isHidden = false
        summedShotsMade += incrementValue
        totalShootingPercentage()
        partialScreenReset()
    }
    
    @IBAction func deleteAllValues(_ sender: UIBarButtonItem) {
        fullScreenReset()
        
    }

    func totalShootingPercentage( ) {
        summedPercentCalc = ((summedShotsMade * 100) / summedShots)
        totalShootingPerc.text = "Today's Shooting Percentage: \(summedPercentCalc)%"
        
        
    }
    
    func buttonPressed() {
        incrementValue += 1
//        enableButtons()
        sliderOutlet.isHidden = true

        if incrementValue > sliderValue {
        disableButtons()
        } else {
            totalPercentCalc = ((incrementValue * 100) / sliderValue)
            self.calcPercentageLbl.text = "\(Int(totalPercentCalc))%"
            self.enteredAmtLbl.text = "Shots Made this Cycle: \(Int(incrementValue))"
            print(incrementValue, totalPercentCalc)
            
            
            
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
    
    func partialScreenReset() {
        enableButtons()
        calcPercentageLbl.text = "0%"
        sliderValue = 15
        enteredAmtLbl.text = "Use Slider to Enter Count"
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        sliderOutlet.isHidden = false
        enteredAmtLbl.text = "Use Slider to Enter Shot Count"
        incrementValue = 0
        upperLeft = 0
        upperLeftLabel.text = "0"
        upperRight = 0
        upperRightLabel.text = "0"
        lowerLeft = 0
        lowerLeftLabel.text = "0"
        lowerRight = 0
        lowerRightLabel.text = "0"
        
    }
    
    func fullScreenReset() {
        partialScreenReset()
        totalShotsTaken.text = "Today's Shots Taken: 0"
        totalShootingPerc.text = "Today's Shooting Percentage: 0%"
        sliderOutlet.isHidden = false
    }
    
    override func viewDidLoad() {
        fullScreenReset()
  

    }

}
