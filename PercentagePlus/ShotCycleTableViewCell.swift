//
//  ShotCycleTableViewCell.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/28/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

class ShotCycleTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalShotsTakenLabel: UILabel!
    @IBOutlet weak var totalShotsMadeLabel: UILabel!
    @IBOutlet weak var cycleShotsMadeLabel: UILabel!
    @IBOutlet weak var totalShotsPercLabel: UILabel!
    @IBOutlet weak var cycleShotsPercLabel: UILabel!
    
    
    func configureCell(shotCycle: ShotCycle) {

        dateLabel.text = "\(dateFormatter())"

        cycleShotsPercLabel.text = "Shoot %: \(shotCycle.shootingPercentage)%"
        totalShotsMadeLabel.text = "Total Shots Made: \(shotCycle.totalHitCount)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
