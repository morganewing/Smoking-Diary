//
//  ViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 6/22/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit

// Global variables
var currActivity = ["Add activity"]
var numCigs = -1
var dateTime = ""
var activityList = [String]()

class ViewController: UITableViewController, UITextFieldDelegate {

//    @IBOutlet var dateTime: UILabel!
    @IBOutlet var cigText: UITextField!
    @IBOutlet var dateLabel: UITextField!
    let datePicker = UIDatePicker()
    @IBOutlet var addActivity: UIButton!
    @IBAction func addActivity(_ sender: Any) {
        
    }
    
    func createDatePicker() {
        // Format date and time
        datePicker.datePickerMode = .dateAndTime
        
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:  #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateLabel.inputAccessoryView = toolbar
        dateLabel.inputView = datePicker
    }
    
    // When datepicker done button pressed
    func donePressed() {
        // Format date and time
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
     
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // Save data when "SAVE" clicked
    @IBAction func saveButton(_ sender: Any) {
        // Check that number of cigs and activities have been selected
        if (numCigs != -1 && currActivity != ["Add activity"]) {
            numCigs = Int(self.cigText.text!)!
            dateTime = self.dateLabel.text!
            activityList = currActivity
            
            let networkManager = NetworkManager()
            
            networkManager.saveEntry(dateTime: dateTime, numCigs: numCigs, activityList: activityList) { (success, error) in
                //
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cigText.delegate = self
        
        // Set default date
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let timeString = "\(hour):\(minutes)"
        dateLabel.text = dateString + " at " + timeString
        
        
        // Set addActivity to selected activity
        addActivity.setTitle("Add activity", for: .normal)
        
        // Set new date when value changed
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        dateLabel.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    
        // Tap anywhere to exit keyboard
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        // Date picker
        createDatePicker()
        
    }
    
    // Text fields return on "return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    // Save num cigs entered
    func textFieldDidEndEditing(_ textField: UITextField) {
        cigText.text = textField.text
        numCigs = Int(cigText.text!)!
    }
    
    // Detect date picker value change
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
    // Update activities
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addActivity.setTitle(currActivity.joined(separator:", "), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Tap anywhere to exit keyboard
    func didTapView() {
        self.view.endEditing(true)
    }
    
    // Hide date picker cell and show all others default
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myCell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellID",for: indexPath as IndexPath) as? UITableViewCell
        
        if (indexPath.row == 2) {
            myCell?.isHidden = true
        } else {
            myCell?.isHidden = false
        }
        
        return myCell!
    }
    
    // Set height of date picker cell to 0 and all others default
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight = 0.0
        
        if (indexPath.row == 1) {
            rowHeight = 0.0
        } else {
            rowHeight = 90.0
        }
        
        return CGFloat(rowHeight)
    }
    
}
