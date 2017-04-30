//
//  HealthManager.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/15/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitManager {
    
    class var sharedInstance: HealthKitManager {
        struct Singleton {
            static let instance = HealthKitManager()
        }
        
        return Singleton.instance
    }
    
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()
    
    let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    
    let stepsUnit = HKUnit.count()
}







//class HealthManager: UIViewController {
//    let healthStore: HKHealthStore? = {
//        if HKHealthStore.isHealthDataAvailable() {
//            return HKHealthStore()
//        } else {
//            return nil
//        }
//    }()
//    
//    override func viewDidLoad() {
//    super.viewDidLoad()
//       self.checkAvailability()
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func checkAvailability() -> Void {
//      //  var healthAvail = true
//        if HKHealthStore.isHealthDataAvailable() {
//            print("Health Data Available")
//            
//        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
//            
//        let dataTypesToWrite = NSSet(object: stepsCount)
//        let dataTypesToRead = NSSet(object: stepsCount)
//        print(stepsCount)
//        healthStore?.requestAuthorization(toShare: dataTypesToWrite as? Set<HKSampleType>,
//            read: dataTypesToRead as! Set<HKObjectType>, completion: { [unowned self] (success, error) in
//                if success {
//                        print("SUCCESS")
//                        } else {
//                        print(error)
//                }
//            })
//
//        }
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
