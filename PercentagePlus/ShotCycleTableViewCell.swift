//
//  ShotCycleTableViewCell.swift
//  BarDown
//
//  Created by Jason Hilimire on 10/22/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import UIKit

class ShotCycleTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalShotsLabel: UILabel!
    @IBOutlet weak var totalMadeLabel: UILabel!
    @IBOutlet weak var shootingPercLabel: UILabel!
    @IBOutlet weak var totalShootingPercLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
