//
//  ViewController.swift
//  PercentagePlus
//
//  Created by Jason Hilimire on 2/1/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit
import AVFoundation


var activeCycle = false
var shotCycles = [ShotCycle]()
let notification = "notificationKey"



class ViewController: UIViewController {
    
    let dataModel = ShotCycleDataModel()
    var shootingCycle = 0

    var currentshotCycle = ShotCycle(date: "", shotsTaken: 0, cyclePercent: 0, shotsMade: 0, ulHitCount: 0, urHitCount: 0, blHitCount: 0, brHitCount: 0)
    
    let impactHaptic = UIImpactFeedbackGenerator()
    let selectionHaptic = UISelectionFeedbackGenerator()
    let notificationHaptic = UINotificationFeedbackGenerator()
    
    
    var audioPlayer = AVAudioPlayer()
    

    
    //MARK:- SETUP
    @IBOutlet weak var percentageLbl: UILabel!
    @IBOutlet weak var enteredAmtLbl: UILabel!
    @IBOutlet weak var sliderLbl: UILabel!
    @IBOutlet weak var shotsMadeLbl: UILabel!
    
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
        currentshotCycle?.brHitCount += 1
        lowerRightLabel.text = "\(currentshotCycle?.brHitCount ?? 0)"
    }
    
    
   
    // saves current values - pressed after all shots/corners entered
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {

        saveShotCycle()
        partialScreenReset()
        resetCorners()
        selectionHaptic.selectionChanged()

        
        // send a notification when pressed- observer will then update the table
        NotificationCenter.default.post(name: Notification.Name(rawValue: notification), object: self)
    }
    
    @IBAction func showSavedCyclesBtn(_ sender: Any) {
        // ...
    }
    

    
    // full delete of all Values
    @IBAction func deleteAllValues(_ sender: UIBarButtonItem) {
        notificationHaptic.notificationOccurred(.error)
        
        let alertController = UIAlertController(title: "Warning!", message: "This will RESET all current shooting info & it will not be saved", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.impactHaptic.impactOccurred()
        }
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Reset", style: .destructive) { action in
            self.impactHaptic.impactOccurred()
            self.fullScreenReset()
 
        }
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true) {
            // ...
        }

    }

    //MARK:- VIEW
    

    override func viewDidLoad() {
        super.viewDidLoad()
            // clear screen-reset when app is launched each time and set slider to default value of 15
        if activeCycle == false {
//            var shootingCycle = 0
            fullScreenReset()
            sliderLbl.text = "Number of Shots: 15"
            sliderValue = 15

        } else {
            partialScreenReset()

        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        activeCycle = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activeCycle = true
 
    }
    
    
    
    //MARK:- METHODS
    

    func saveShotCycle() {
        shootingCycle += 1
        sliderOutlet.isHidden = false
        shotsMadeLbl.text = "Total Shots Made: 0"
        let date = dateFormatter()
        let shotCycle = ShotCycle(date: date, shotsTaken: sliderValue, cyclePercent: updatePercent(), shotsMade: updateShotsMade(), ulHitCount: (currentshotCycle?.ulHitCount)!, urHitCount: (currentshotCycle?.urHitCount)!, blHitCount: (currentshotCycle?.blHitCount)!, brHitCount: (currentshotCycle?.brHitCount)!)

        shotCycles.append(shotCycle!)
        saveData()

    }
    
    
    // increments values in buttons and updates percent calculations
    func buttonPressed() {
        sliderOutlet.isHidden = true
        enteredAmtLbl.isHidden = true
        updateShotsMade()
        updatePercent()
        impactHaptic.impactOccurred()
        
        let buttonClick = NSURL(fileURLWithPath: Bundle.main.path(forResource: "button_press", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: buttonClick as URL)
            audioPlayer.prepareToPlay()
        } catch {
            print("No file found")
        }
        audioPlayer.play()
        

    }
    
    func updateShotsMade() -> Int {
        let shotsMade = (currentshotCycle?.sumHitCounts(ulHitCount: (currentshotCycle?.ulHitCount)!, urHitCount: (currentshotCycle?.urHitCount)!, blHitCount: (currentshotCycle?.blHitCount)!, brHitCount: (currentshotCycle?.brHitCount)!))! + 1
        print("ShotsMade: \(String(describing: shotsMade))")
        if shotsMade == sliderValue {
            disableButtons()
            shotsMadeLbl.text = "Total Shots Made: \(sliderValue)"
            
        } else {
            shotsMadeLbl.text = "Total Shots Made: \(shotsMade)"
        }
        
        return shotsMade
    }
    
    func updatePercent() -> Int{
        let shootingPerc = currentshotCycle?.getCyclePercent(shotsTaken: sliderValue, shotsMade: updateShotsMade())

            percentageLbl.text = "\(String(describing: shootingPerc!))%"
        return shootingPerc!
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
    }

    
    func partialScreenReset(action: UIAlertAction! = nil) {
        enableButtons()
        percentageLbl.text = "0%"
        enteredAmtLbl.text = "Use Slider to Enter Count"
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"
        sliderOutlet.isHidden = false
        enteredAmtLbl.text = "Use Slider to Enter Shot Count"
        shotsMadeLbl.text = "Total Shots Made: 0"

    }
    
    
    // full reset of all data values excluding slider
    func fullScreenReset() {
        partialScreenReset()
        resetCorners()
        resetValues()

    }
    
    func resetValues() {

        shotsMadeLbl.text = "Total Shots Made: 0"
        sliderOutlet.isHidden = false
        sliderLbl.text = "Number of Shots: \(Int(sliderValue))"        
        resetCorners()

    }
    

    
    func saveData() {
        dataModel.saveShotCycleArray()

    }
    
    func dateFormatter() -> String{
        let currentDate = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let dateString = formatter.string(from: currentDate as Date)
        return dateString
    }
    
}






