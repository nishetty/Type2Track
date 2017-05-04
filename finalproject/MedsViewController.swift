//
//  MedsViewController.swift
//  finalproject
//
//  Created by Nishita Shetty on 3/28/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit

class MedsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var medNameReceived = ""
    var timesPerDayReceived = ""
    
    var currentMed = ""
    var currentTimePerDay = ""
    
    var medDict: [String:Int] = [:]
    
    @IBOutlet weak var medTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medTableView.delegate = self
        medTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if self.medNameReceived != "" && self.timesPerDayReceived != "" {
            medDict[self.medNameReceived] = Int(self.timesPerDayReceived)
        }
        self.medTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToMeds(segue: UIStoryboardSegue){}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medDict.keys.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medCell") as! MedCell
        var medications = Array(medDict.keys)
        cell.medName.text = medications[indexPath.row]
        cell.timesPerDay.text = String(describing: medDict[cell.medName.text!]!)
        self.currentMed = cell.medName.text!
        self.currentTimePerDay = cell.timesPerDay.text!
        var doseListCurrent = doseTimeDict[self.currentMed]!
        var stringofTimes = ""
        for key in Array(doseListCurrent.keys){
            stringofTimes += doseListCurrent[key]! + "    "
        }
        cell.timeforDose.text = stringofTimes
        return cell
    }
    
    func deleteEntry(medToDelete: String) -> Void{
        doseTimeDict.removeValue(forKey: medToDelete)
        medDict.removeValue(forKey: medToDelete)
        self.medTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doseVC = DoseViewController()
        let cell = tableView.dequeueReusableCell(withIdentifier: "medCell") as! MedCell
        var medications = Array(medDict.keys)
        let alert = UIAlertController(title: "Delete medication?", message: "This will permanently delete this medication entry & alerts.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: {action in
            self.deleteEntry(medToDelete: medications[indexPath.row])
            doseVC.removeNotification(medicationName: cell.medName.text!)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
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
