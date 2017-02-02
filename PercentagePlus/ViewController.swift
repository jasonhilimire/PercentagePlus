//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit


var calcPercent = 0
var amountValue: Double = 10
var incrementValue: Double = 0

class ViewController: UIViewController {

    @IBOutlet weak var calcPercentageLbl: UILabel!
    @IBOutlet weak var enteredAmtLbl: UILabel!
    @IBOutlet weak var numberEntry: UITextField!
    @IBAction func incrementBtnPressed(_ sender: UIButton) {
        
        incrementValue += 1
        
        if let totalPercentCalc = Double? (incrementValue / amountValue) {
            let totalPercentConverted = totalPercentCalc * 100
            calcPercentageLbl.text = "\(totalPercentConverted)%"
            enteredAmtLbl.text = "\(incrementValue) / \(amountValue)"
            print(incrementValue, totalPercentConverted)
            
            
        }
        
        
    }
   
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        calcPercentageLbl.text = "0%"
        enteredAmtLbl.text = "Enter Amount"
        
        
    }

    func ConvertNumber(_ : Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        numberFormatter.formatterBehavior = .default
        let incrementValueChanged = numberFormatter.string(from: NSNumber(value: incrementValue))
        return incrementValueChanged!
    }
    
   
    
    
    
    override func viewDidLoad() {

    }



}

