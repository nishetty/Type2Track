//
//  FirstViewController.swift
//  finalproject
//
//  Created by Nishita Shetty on 3/20/17.
//  Copyright © 2017 Nishita Shetty. All rights reserved.
//

import UIKit
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
class InfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
//Type2Track
    
    
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var heightFeet: UITextField!
    @IBOutlet weak var heightInches: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var BMIResult: UILabel!
    @IBOutlet weak var BMICalc: UILabel!

    @IBOutlet weak var beforeMealLow: UITextField!
    @IBOutlet weak var beforeMealHigh: UITextField!
    @IBOutlet weak var afterMealLow: UITextField!
    @IBOutlet weak var afterMealHigh: UITextField!
    
    @IBOutlet weak var updatedLabel: UILabel!
    
    
    var BMIValue = 0.00
    
    var timer = Timer()
    
    func Hide() {
        updatedLabel.isHidden = true
        timer.invalidate()  //You can remove timer here.
    }
    
    @IBAction func updateInfo(_ sender: UIButton) {
        updatedLabel.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("Hide"), userInfo: nil, repeats: false)
        
      //  self.updatedLabel.isHidden = true
        if heightFeet.text != "" || heightInches.text != "" || weight.text != "" {
            self.BMIValue = calcBMI(heightFeet: (Double(heightFeet.text!))!, heightInches: (Double(heightInches.text!))!,weight: (Double(weight.text!))!)
        }
        BMICalc.text = String(format:"%.2f", BMIValue)
        if BMIValue != 0.00{
            if BMIValue < 18.5 {
                BMIResult.text = "Underweight"
                return}
            if BMIValue < 24.9 {
                BMIResult.text = "Normal"
                return}
            if BMIValue < 29.9 {
                BMIResult.text = "Overweight"
                return}
            if BMIValue > 29.9 {
                BMIResult.text = "Obese"
                return}

            }
        if beforeMealLow.text != "" {
            beforeMealLowValue = Int(beforeMealLow.text!)!
        }
        if beforeMealHigh.text != ""{
            beforeMealHighValue = Int(beforeMealHigh.text!)!
        }
        if afterMealLow.text != ""{
            afterMealLowValue = Int(afterMealLow.text!)!
        }
        if afterMealHigh.text != ""{
            afterMealHighValue = Int(afterMealHigh.text!)!
        }
    
    }
    
    var gender: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 1.5)
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        gender = ["Male", "Female"]
        updatedLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcBMI(heightFeet: Double, heightInches: Double, weight: Double) -> Double {
        let weightKilos = weight * 0.453592
        let heightTotalInches = 12 * heightFeet + heightInches
        let heightMeters = heightTotalInches * 0.0254
        return(weightKilos / (heightMeters * heightMeters))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    

    
}

