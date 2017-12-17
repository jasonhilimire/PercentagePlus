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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
