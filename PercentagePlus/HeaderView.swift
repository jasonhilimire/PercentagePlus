//
//  HeaderViewTableViewCell.swift
//  BarDown
//
//  Created by Jason Hilimire on 12/17/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

class HeaderView: UITableViewCell {

    @IBOutlet var totalShotsMade: UILabel!
    @IBOutlet var totalShotsTaken: UILabel!
    @IBOutlet var totalShotPerc: UILabel!
    @IBOutlet var tlMade: UILabel!
    @IBOutlet var blMade: UILabel!
    @IBOutlet var brMade: UILabel!
    @IBOutlet var trMade: UILabel!

    @IBOutlet var vw: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
