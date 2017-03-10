//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit


var sliderValue: Double = 0.0
var incrementValue: Double = 0.0

class ViewController: UIViewController {

    @IBOutlet weak var calcPercentageLbl: UILabel!
    @IBOutlet weak var enteredAmtLbl: UILabel!
    @IBOutlet weak var sliderLbl: UILabel!
    @IBOutlet weak var incrementButtonUL: UIButton!

    @IBOutlet weak var incrementButtonUR: UIButton!
    @IBOutlet weak var incrementButtonBL: UIButton!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var incrementButtonBR: UIButton!

    @IBAction func slider(_ sender: UISlider) {
        
        sliderValue = Double(sender.value)
        sliderLbl.text = "\(Int(sliderValue))"
        
    }

    
    @IBAction func incrementBtnPressedUL(_ sender: UIButton) {
       buttonPressed()
        
}

    @IBAction func incrementButtonPressedUR(_ sender: UIButton) {
         buttonPressed()
    }
    
    
    @IBAction func incrementButtonPressedBL(_ sender: UIButton) {
         buttonPressed()
    }
   
    @IBAction func incrementButtonPressedBR(_ sender: UIButton) {
         buttonPressed()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        calcPercentageLbl.text = "0%"
        enteredAmtLbl.text = "Enter Amount"
        incrementValue = 0
        incrementButtonUL.isEnabled = true
        incrementButtonBL.isEnabled = true
        incrementButtonBR.isEnabled = true
        incrementButtonUR.isEnabled = true
        sliderOutlet.isHidden = false

    }


    func buttonPressed() {
        incrementValue += 1.0
        enableButtons()
        sliderOutlet.isHidden = true

        if incrementValue > sliderValue {
        disableButtons()
        } else {
            if let totalPercentCalc = Double? (incrementValue / sliderValue) {
                let totalPercentConverted: Double = totalPercentCalc * 100
                self.calcPercentageLbl.text = "\(Double(totalPercentConverted))%"
                self.enteredAmtLbl.text = "\(Int(incrementValue)):\(Int(sliderValue))"
                print(incrementValue, totalPercentConverted)
            }
            
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
    
    override func viewDidLoad() {
        enableButtons()
        sliderValue = 10
        sliderLbl.text = "\(Int(sliderValue))"

    }

}
