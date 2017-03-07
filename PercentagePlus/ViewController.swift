//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit


var calcPercent = 0
//var amountValue: Double = 10
var incrementValue: Double = 0

class ViewController: UIViewController {

    @IBOutlet weak var calcPercentageLbl: UILabel!
    @IBOutlet weak var enteredAmtLbl: UILabel!
    @IBOutlet weak var numberEntry: UITextField!
    

    
    @IBAction func incrementBtnPressed(_ sender: UIButton) {
        
        incrementValue += 1
        let shotsTaken = Double(numberEntry.text!)
        
        if let totalPercentCalc = Double? (incrementValue / shotsTaken!) {
            let totalPercentConverted = totalPercentCalc * 100
            calcPercentageLbl.text = "\(totalPercentConverted)%"
            enteredAmtLbl.text = "\(incrementValue):\(String(describing: shotsTaken)))"
            print(incrementValue, totalPercentConverted)
            
            
        }
        
        
    }
   
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        
        calcPercentageLbl.text = "0%"
        enteredAmtLbl.text = "Enter Amount"
        calcPercent = 0
        incrementValue = 0
        
        
    }


   
    
    
    
    override func viewDidLoad() {
        
       
    



    }

}
