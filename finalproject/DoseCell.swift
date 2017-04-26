//
//  DoseCell.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/16/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit

class DoseCell: UITableViewCell {

    @IBOutlet weak var doseNumber: UILabel!
    
    @IBOutlet weak var doseTimePicker: UIDatePicker!

    @IBAction func doseTimePickerAction(_ sender: UIDatePicker) {
    
    }
    var dosestrDate = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //doseTimePicker.addTarget(self, action: Selector("datePickerChanged:"), for: UIControlEvents.valueChanged)
    }
//func datePickerChanged(datePicker:UIDatePicker) {
   // let dateFormatter = DateFormatter()
        
    //dosestrDate = dateFormatter.string(from: datePicker.date)
    
 //   }
}
