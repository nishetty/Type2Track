//
//  ActivityViewController.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/29/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit
import HealthKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var activityTableView: UITableView!
    let healthKitManager = HealthKitManager.sharedInstance
    
    var dateArray = [String]()
    var stepsArray = [String]()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        return formatter
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestHealthKitAuthorization()
        activityTableView.delegate = self
        activityTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell") as! ActivityCell
        let numberOfSteps = stepsArray[indexPath.row]
        cell.numberSteps?.text = "\((numberOfSteps)) steps"
        cell.activityDate?.text = dateArray[indexPath.row]
        cell.activityDate?.font = UIFont.boldSystemFont(ofSize: 17.0)
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.cyan
        } else {
            if Int(numberOfSteps)! > 10000{
            cell.backgroundColor = UIColor.green}
            else{
            cell.backgroundColor = UIColor.white}
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }


}
extension ActivityViewController {
    
    func requestHealthKitAuthorization() {
        let dataTypesToRead = NSSet(objects: healthKitManager.stepsCount as Any)
        healthKitManager.healthStore?.requestAuthorization(toShare: nil, read: dataTypesToRead as? Set<HKObjectType>, completion: { [unowned self] (success, error) in
            if success {
                DispatchQueue.main.async {
                self.querySteps()
                }
                
            } else {
                print("error in request health kit")
                print(error.debugDescription)
            }
        })
}
    func querySteps() {
        let calendar = NSCalendar.current
        let interval = NSDateComponents()
        interval.day = 1
        let stepsCount = HKQuantityType.quantityType(
                    forIdentifier: HKQuantityTypeIdentifier.stepCount)
        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: NSDate() as Date)
        anchorComponents.hour = 0
        let anchorDate = calendar.date(from: anchorComponents)
        
        // Define 1-day intervals starting from 0:00
        let stepsQuery = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: anchorDate!, intervalComponents: interval as DateComponents)
        
        // Set the results handler
        stepsQuery.initialResultsHandler = {query, results, error in
            let endDate = NSDate()
            let startDate = calendar.date(byAdding: .day, value: -30, to: endDate as Date, wrappingComponents: false)
            if let myResults = results{
                myResults.enumerateStatistics(from: startDate!, to: endDate as Date) { statistics, stop in
                    if let quantity = statistics.sumQuantity(){
                        let date = statistics.startDate
                        let dateString = self.dateFormatter.string(from: date)
                        self.dateArray.insert(dateString, at: 0)
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        self.stepsArray.insert(String(Int(steps)), at: 0)
                        print("\(date): steps = \(steps)")
                        //NOTE: If you are going to update the UI do it in the main thread
                        DispatchQueue.main.async {
                        self.activityTableView.reloadData()
                        }

                        
                    }
                } //end block
            } //end if let
        }
            self.healthKitManager.healthStore?.execute(stepsQuery)
        
    }


}
