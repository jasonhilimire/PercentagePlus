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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
