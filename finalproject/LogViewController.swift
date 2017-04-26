//
//  SecondViewController.swift
//  finalproject
//
//  Created by Nishita Shetty on 3/20/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit

class LogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var glucoseDict: [Date: [String]] = [:]
    var dateCreated = Date()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindToLog(segue: UIStoryboardSegue){}
    
   // @IBOutlet weak var activityTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glucoseDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "glucoseCell") as! GlucoseCell
        print("glucose Dict", glucoseDict)
        var dateCreatedArray = Array(glucoseDict.keys)
        cell.glucoseValue.text = self.glucoseDict[dateCreatedArray[indexPath.row]]?[2]
        cell.mealAssign.text = self.glucoseDict[dateCreatedArray[indexPath.row]]?[1]
        cell.readingDate.text = self.glucoseDict[dateCreatedArray[indexPath.row]]?[0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }


}

