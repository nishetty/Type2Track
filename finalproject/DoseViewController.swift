//
//  DoseViewController.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/15/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit
import UserNotifications

extension DoseViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
}

class DoseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var medName: UITextField!
    @IBOutlet weak var timesPerDay: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func returnToMedVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func setTimes(_ sender: Any) {
        self.tableView.reloadData()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        UNUserNotificationCenter.current().delegate = self
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveDoseInfo(_ sender: Any) {
        if doseTimeDict.keys.contains(medName.text!){
            let repeatedNameAlert = UIAlertController(title: "Medication name already exists.", message: "Would you like to replace your existing medication details?", preferredStyle: UIAlertControllerStyle.alert)
            repeatedNameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {action in return}))
            repeatedNameAlert.addAction(UIAlertAction(title: "Replace", style: UIAlertActionStyle.default, handler: {action in self.saveDoseInfoAction()}))
            self.present(repeatedNameAlert, animated: true, completion: nil)
            
        } else {
            saveDoseInfoAction()
        }

    }
    func saveDoseInfoAction(){
        if medName.text != ""{
            var currentMedDict = [Int : String]()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h : mm a"
            if timesPerDay.text == "" {
                timesPerDay.text = "1"
            }
            for i in 0...Int(timesPerDay.text!)!-1 {
                let cell = tableView(tableView, cellForRowAt: IndexPath(row: i, section: 0)) as! DoseCell
                let strDate = dateFormatter.string(from: cell.doseTimePicker.date)
                currentMedDict[i+1] = strDate
                UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
                    switch notificationSettings.authorizationStatus {
                    case .notDetermined:
                        self.requestAuthorization(completionHandler: { (success) in
                            guard success else { return }
                            
                            // Schedule Local Notification
                            self.scheduleLocalNotification(medicationName: self.medName.text!, doseDate: cell.doseTimePicker.date)
                        })
                    case .authorized:
                    // Schedule Local Notification
                        self.scheduleLocalNotification(medicationName: self.medName.text!, doseDate: cell.doseTimePicker.date)
                    case .denied:
                        print("Application Not Allowed to Display Notifications")
                    }
                }
                
                
            }
        doseTimeDict[medName.text!] = currentMedDict
        print(doseTimeDict)
        self.performSegue(withIdentifier: "unwindToMeds", sender: self)
    } else {
        let alert = UIAlertController(title: "Oops!", message: "Please enter all info.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
            }
        }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MedsViewController
            destination.medNameReceived = medName.text!
            destination.timesPerDayReceived = timesPerDay.text!
        }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if timesPerDay.text == "" {
            return 1
        }else {
            return Int(timesPerDay.text!)!
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doseCell") as! DoseCell
        cell.doseNumber.text = String(describing: indexPath.row+1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func scheduleLocalNotification(medicationName: String, doseDate: Date){
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "Time to take your " + medicationName + " !"
        //notificationContent.subtitle = "Local Notifications"
      //  notificationContent.body = "In this tutorial, you learn how to schedule local notifications with the User Notifications framework."
        
        // Add Trigger
       
        let calendar = Calendar.current
        let receivedDateComp = calendar.dateComponents([.hour, .minute], from: doseDate)
        let hour = receivedDateComp.hour
        let minute = receivedDateComp.minute
        
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: components as DateComponents, repeats: true)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: medicationName + String(describing: doseDate), content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest){ (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        

    }
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
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