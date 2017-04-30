//
//  AddGlucoseViewController.swift
//  finalproject
//
//  Created by Nishita Shetty on 4/23/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit

class AddGlucoseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.glucoseMeal.delegate = self
        self.glucoseMeal.dataSource = self
        meals = ["Before Breakfast", "After Breakfast", "Before Lunch", "After Lunch", "Before Dinner", "After Dinner"]

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnToLogVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var meals: [String] = [String]()
    @IBOutlet weak var glucoseDate: UIDatePicker!
    
    @IBOutlet weak var glucoseMeal: UIPickerView!
    
    @IBOutlet weak var glucoseReading: UITextField!
    
    var mealSelected = ""
    
    @IBAction func addGlucose(_ sender: Any) {
        numberofGlucoseEntries += 1
        print("the number of glucose entries is" + String(numberofGlucoseEntries))
        self.performSegue(withIdentifier: "unwindToLog", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("this is prepare for segue")
        let destination = segue.destination as! LogViewController
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let currentDateTime = Date()
        let dateString = dateFormatter.string(from: glucoseDate.date)
        destination.glucoseDict[currentDateTime] = [dateString, String(self.mealSelected), glucoseReading.text!]
    }
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meals.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return meals[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.mealSelected = meals[row]
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
