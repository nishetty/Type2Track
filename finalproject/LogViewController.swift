//
//  SecondViewController.swift
//  finalproject
//
//  Created by Nishita Shetty on 3/20/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit

class LogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var glucoseDate = ""
    var glucoseMeal = ""
    var glucoseReading: Int = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
   // @IBOutlet weak var activityTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberofGlucoseEntries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glucoseCell") as! GlucoseCell
        cell.glucoseValue.text = String(self.glucoseReading)
        cell.mealAssign.text = self.glucoseMeal
        cell.readingDate.text = self.glucoseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }


}

