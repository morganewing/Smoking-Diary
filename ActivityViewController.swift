//
//  ActivityViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 6/27/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit
import os.log

var customAct = [String]()
// Number of custom activities
var new = 0

class ActivityViewController: UITableViewController, UITextFieldDelegate {
    
    var updateActivity = [String]()
    
    // Update activities when done button pressed
    @IBAction func doneButton(_ sender: Any) {
        if (updateActivity.count > 0) {
            currActivity = updateActivity
        }
    }
    
    // Default list of activities
    var activities = ["Eating", "Drinking", "Coffee", "Driving", "Social"]
    // Array of custom activies
    @IBOutlet var newActivityText: UITextField!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (activities.count + new) + 1
    }
    
    // Add custom activity when "Add" pressed
    @IBAction func addButton(_ sender: Any) {
        // New activity array
        new = 1
        self.tableView.beginUpdates()
        let newItemIndexPath = IndexPath(row: (activities.count + new)-1, section: 0)
        self.tableView.insertRows(at: [newItemIndexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
    }
    
    // Delete custom activity row when "Del" pressed
    @IBAction func deleteButton(_ sender: Any) {
        self.tableView.beginUpdates()
        let newItemIndexPath = IndexPath(row: (activities.count + new)-1, section: 0)
        self.tableView.deleteRows(at: [newItemIndexPath], with: UITableViewRowAnimation.automatic)
        new -= 1
        self.tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Default activity row
        if (indexPath.row < activities.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = activities[indexPath.row]
            return cell
        } else {
            // Added new activity row
            if (indexPath.row < (activities.count + new)) {
                let added = tableView.dequeueReusableCell(withIdentifier: "added", for: indexPath)
                return added
            // Add activity option row
            } else {
                let custom = tableView.dequeueReusableCell(withIdentifier: "custom", for: indexPath)
                return custom
            }
        }
    }
    
    // Add checkmarks and set currActivity to selected activity
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row < (activities.count + new)) {
            let currCell = tableView.cellForRow(at: indexPath)
            if currCell?.accessoryType == UITableViewCellAccessoryType.checkmark {
                currCell?.accessoryType = UITableViewCellAccessoryType.none
                // Remove activity from list
                if (indexPath.row < activities.count) {
                    if let itemToRemoveIndex = updateActivity.index(of: (currCell?.textLabel!.text)!) {
                        updateActivity.remove(at: itemToRemoveIndex)
                    }
                } else {
                    //remove custom activity!!!!
                }
            } else {
                currCell?.accessoryType = UITableViewCellAccessoryType.checkmark
                // Add activity to list
                if (indexPath.row < activities.count) {
                    updateActivity.append((currCell?.textLabel!.text)!)
                } else {
                     if (indexPath.row < (activities.count + new)) {
                        updateActivity.append(customAct[indexPath.row-activities.count])
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
