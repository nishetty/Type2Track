//
//  HealthManager.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/15/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit
import HealthKit

class HealthManager: UIViewController {
let healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkAvailability()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAvailability() -> Bool {
        var healthAvail = true
        if HKHealthStore.isHealthDataAvailable() {
            print("Health Data Available")
            
        let heightKit = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height))
        let weightKit = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass))
        
     //   healthStore.requestAuthorization(toShare: nil, read: heightKit as! Set<HKObjectType>, completion: {(success, error) in
       //     healthAvail = success)
            

        }
        
        else{
            let healthAvail = false
            print("No HealthKit Data available")
        }
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
