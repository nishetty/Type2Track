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
    
    let beforeMeals = ["Before Breakfast", "Before Lunch", "Before Dinner"]
    let afterMeals = ["After Breakfast", "After Lunch", "After Dinner"]

   
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
        var dateCreatedArray = Array(glucoseDict.keys).sorted(by: >)
        cell.glucoseValue.text = self.glucoseDict[dateCreatedArray[indexPath.row]]?[2]
        cell.mealAssign.text = self.glucoseDict[dateCreatedArray[indexPath.row]]?[1]
        if cell.mealAssign.text == "" {
            cell.mealAssign.text = "Before Breakfast"
        }
        cell.readingDate.text = self.glucoseDict[dateCreatedArray[indexPath.row]]?[0]
        cell.glucoseIndicator.text = ""
        let glucoseValue = Int(cell.glucoseValue.text!)!
        if beforeMeals.contains(cell.mealAssign.text!) {
            if beforeMealLowValue != 0 && beforeMealHighValue != 0 {
                if glucoseValue >= beforeMealLowValue && glucoseValue <= beforeMealHighValue {
                    cell.glucoseValue.textColor = UIColor.green
                    cell.glucoseIndicator.text = "In Range!"
                    cell.glucoseIndicator.textColor = UIColor.green
                }
                else
                {cell.glucoseValue.textColor = UIColor.red
                    if glucoseValue < beforeMealLowValue {
                        cell.glucoseIndicator.text = "Low!"
                        cell.glucoseIndicator.textColor = UIColor.red
                        cell.glucoseValue.highlightedTextColor = UIColor.lightGray
                    } else {cell.glucoseIndicator.text = "High!"
                            cell.glucoseIndicator.textColor = UIColor.red
                            cell.glucoseValue.highlightedTextColor = UIColor.lightGray
                            }
                    }
            }
        }
        if afterMeals.contains(cell.mealAssign.text!) {
            if afterMealLowValue != 0 && afterMealHighValue != 0 {
                if glucoseValue >= afterMealLowValue && glucoseValue <= afterMealHighValue {
                    cell.glucoseValue.textColor = UIColor.green
                    cell.glucoseIndicator.text = "In range!"
                    cell.glucoseIndicator.textColor = UIColor.green
                }
                else
                {cell.glucoseValue.textColor = UIColor.red
                    if glucoseValue < afterMealLowValue {
                        cell.glucoseIndicator.text = "Low!"
                        cell.glucoseIndicator.textColor = UIColor.red
                    
                    } else {cell.glucoseIndicator.text = "High!"
                        cell.glucoseIndicator.textColor = UIColor.red
                                            }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }


}

