//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit


var sliderValue: Double = 10.0
var incrementValue: Double = 0.0

class ViewController: UIViewController {

    @IBOutlet weak var calcPercentageLbl: UILabel!
    @IBOutlet weak var enteredAmtLbl: UILabel!
    @IBOutlet weak var sliderLbl: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBAction func slider(_ sender: UISlider) {

        sliderValue = Double(sender.value)
        sliderLbl.text = "\(Int(sliderValue))"
        
    }
    @IBOutlet weak var sliderOutlet: UISlider!

    

    
    @IBAction func incrementBtnPressed(_ sender: UIButton) {
        
        incrementValue += 1.0
        incrementButton.isEnabled = true
        sliderOutlet.isHidden = true
        
        if incrementValue > sliderValue {
            incrementButton.isEnabled = false
        } else {
            if let totalPercentCalc = Double? (incrementValue / sliderValue) {
                let totalPercentConverted: Double = totalPercentCalc * 100
                self.calcPercentageLbl.text = "\(totalPercentConverted)%"
                self.enteredAmtLbl.text = "\(Int(incrementValue)):\(Int(sliderValue))"
                print(incrementValue, totalPercentConverted)
            }
            
        }
        
        
}

    
    
   
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        calcPercentageLbl.text = "0%"
        enteredAmtLbl.text = "Enter Amount"
        incrementValue = 0
        incrementButton.isEnabled = true
        sliderOutlet.isHidden = false

    }


    
    
    
    override func viewDidLoad() {
        
       
    



    }

}
