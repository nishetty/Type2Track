//
//  GlucoseCell.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/23/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit

class GlucoseCell: UITableViewCell {

    
    @IBOutlet weak var glucoseValue: UILabel!
    
    @IBOutlet weak var mealAssign: UILabel!
    
    @IBOutlet weak var readingDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
