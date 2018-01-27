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
var currLocation = ["Add location"]
var currPeople = ["Add people"]
var currMood = ["Add mood"]
var numCigs = -1
var dateTime = ""
var activityList = [String]()
var locationList = [String]()
var peopleList = [String]()
var moodList = [String]()
var edit = 0
var editInital = 1
var uniqueId = -1
// Selected item variables
var updateActivity = [String]()
var updateLocation = [String]()
var updatePeople = [String]()
var updateMood = [String]()
var meth = ""

class ViewController: UITableViewController, UITextFieldDelegate {
    
    // Default icons, buttons, and text fields
    @IBOutlet var cigText: UITextField!
    @IBOutlet var dateLabel: UITextField!
    let datePicker = UIDatePicker()
    @IBOutlet var addActivity: UIButton!
    @IBAction func addActivity(_ sender: Any) {
        
    }
    @IBOutlet var addLocation: UIButton!
    @IBOutlet var addPeople: UIButton!
    @IBOutlet var addMood: UIButton!
    @IBOutlet var dateIcon: UIImageView!
    @IBOutlet var cigIcon: UIImageView!
    @IBOutlet var activityIcon: UIImageView!
    @IBOutlet var locationIcon: UIImageView!
    @IBOutlet var peopleIcon: UIImageView!
    @IBOutlet var moodIcon: UIImageView!
    
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
        dateLabel.textColor = UIColor.black
        self.view.endEditing(true)
        // Change icon to enabled
        dateIcon.image = #imageLiteral(resourceName: "Time Enabled")
    }
    
    // Save data when "SAVE" clicked
    @IBAction func saveButton(_ sender: Any) {
        // Check that number of cigs and activities have been selected
        if (Int(self.cigText.text!) != -1) {
            numCigs = Int(self.cigText.text!)!
            dateTime = self.dateLabel.text!
            activityList = currActivity
            locationList = currLocation
            peopleList = currPeople
            moodList = currMood
            
            let networkManager = NetworkManager()
            
            if (edit == 0) {
                networkManager.saveEntry(dateTime: dateTime, numCigs: numCigs, activityList: activityList, locationList: locationList, peopleList: peopleList, moodList: moodList, method: "add") { (success, error) in
                    //
                }
            } else {
                networkManager.editEntry(dateTime: dateTime, numCigs: numCigs, activityList: activityList, locationList: locationList, peopleList: peopleList, moodList: moodList, uniqueId: uniqueId, method: "edit") { (success, error) in
                    //
                }
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
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // Save num cigs entered
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (cigText.text != "Add number of cigarettes") {
            cigText.text = textField.text
            numCigs = Int(cigText.text!)!
            // Change icon to enabled
            cigIcon.image = #imageLiteral(resourceName: "Cigarettes Enabled")
        }
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
        if (edit == 1) {
            if (editInital == 0) {
                addActivity.setTitle(currActivity.joined(separator:", "), for: .normal)
                addLocation.setTitle(currLocation.joined(separator:", "), for: .normal)
                addPeople.setTitle(currPeople.joined(separator:", "), for: .normal)
                addMood.setTitle(currMood.joined(separator:", "), for: .normal)
            } else {
                numCigs = entCigs
                dateTime = dateLabel.text!
                currActivity = entActivity
                currLocation = entLocation
                currPeople = entPeople
                currMood = entMood
                uniqueId = entId
                updateActivity = currActivity
                updateLocation = currLocation
                updatePeople = currPeople
                updateMood = currMood
                
                dateLabel.text = entDate
                cigText.text = String(entCigs)
                addActivity.setTitle(entActivity.joined(separator:", "), for: .normal)
                addLocation.setTitle(entLocation.joined(separator:", "), for: .normal)
                addPeople.setTitle(entPeople.joined(separator:", "), for: .normal)
                addMood.setTitle(entMood.joined(separator:", "), for: .normal)
                
                // Change text color to black
                dateLabel.textColor = UIColor.black
                self.view.endEditing(true)
                // Change icon to enabled
                dateIcon.image = #imageLiteral(resourceName: "Time Enabled")
                // Change icon to enabled
                cigIcon.image = #imageLiteral(resourceName: "Cigarettes Enabled")
                // Change icon to enabled
                activityIcon.image = #imageLiteral(resourceName: "Activity Enabled")
                // Change text color to black
                addActivity.setTitleColor(UIColor.black, for: .normal)
                // Change icon to enabled
                locationIcon.image = #imageLiteral(resourceName: "Location Enabled")
                // Change text color to black
                addLocation.setTitleColor(UIColor.black, for: .normal)
                // Change icon to enabled
                peopleIcon.image = #imageLiteral(resourceName: "People Enabled")
                // Change text color to black
                addPeople.setTitleColor(UIColor.black, for: .normal)
                moodIcon.image = #imageLiteral(resourceName: "Mood Enabled")
                // Change text color to black
                addMood.setTitleColor(UIColor.black, for: .normal)
            }
            editInital = 0
        } else {
            // If edit = 0 (entry not edited)
            if (currActivity != ["Add activity"]) {
                addActivity.setTitle(currActivity.joined(separator:", "), for: .normal)
                // Change icon to enabled
                activityIcon.image = #imageLiteral(resourceName: "Activity Enabled")
                // Change text color to black
                addActivity.setTitleColor(UIColor.black, for: .normal)
            }
            if (currLocation != ["Add location"]) {
                addLocation.setTitle(currLocation.joined(separator:", "), for: .normal)
                // Change icon to enabled
                locationIcon.image = #imageLiteral(resourceName: "Location Enabled")
                // Change text color to black
                addLocation.setTitleColor(UIColor.black, for: .normal)
            }
            if (currPeople != ["Add people"]) {
                addPeople.setTitle(currPeople.joined(separator:", "), for: .normal)
                // Change icon to enabled
                peopleIcon.image = #imageLiteral(resourceName: "People Enabled")
                // Change text color to black
                addPeople.setTitleColor(UIColor.black, for: .normal)
            }
            if (currMood != ["Add mood"]) {
                addMood.setTitle(currMood.joined(separator:", "), for: .normal)
                // Change icon to enabled
                moodIcon.image = #imageLiteral(resourceName: "Mood Enabled")
                // Change text color to black
                addMood.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
    }
    
}
