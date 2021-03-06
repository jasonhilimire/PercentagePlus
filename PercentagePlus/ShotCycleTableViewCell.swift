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
    @IBOutlet weak var shotsTakenLabel: UILabel!
    @IBOutlet weak var shotsMadeLabel: UILabel!
    @IBOutlet weak var shotsPercLabel: UILabel!

    @IBOutlet var ulLabel: UILabel!
    @IBOutlet var urLabel: UILabel!
    @IBOutlet var brLabel: UILabel!
    @IBOutlet var blLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
