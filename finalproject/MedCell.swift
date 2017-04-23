//
//  MedCell.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/16/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit

class MedCell: UITableViewCell {

    @IBOutlet weak var timesPerDay: UILabel!
    @IBOutlet weak var medName: UILabel!
    
    @IBOutlet weak var timeforDose: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
