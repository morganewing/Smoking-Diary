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
    
    @IBAction func doneButton(_ sender: Any) {
        if (updateActivity.count > 0) {
            currActivity = updateActivity
            if currActivity.contains("Add activity") {
                currActivity.remove(at: 0)
            }
            print(currActivity)
        }
        print("soo")
        performSegue(withIdentifier: "activityReturn", sender: self)
    }
    
    // Default list of activities
    var activities = ["Eating", "Drinking", "Coffee", "Driving", "Social"]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (activities.count + new) + 1
    }
    
    // Add custom activity when "Add" pressed
    @IBAction func addButton(_ sender: Any) {
        // New activity array
        self.tableView.beginUpdates()
        new += 1
        let newItemIndexPath = IndexPath(row: (activities.count + new)-1, section: 0)
        self.tableView.insertRows(at: [newItemIndexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
    }
    
    // Delete custom activity row when "Del" pressed
    @IBAction func deleteButton(_ sender: UIButton) {
        self.tableView.beginUpdates()
        print((activities.count + new)-1)
        let newItemIndexPath = IndexPath(row: (activities.count + new)-1, section: 0)
        var index = new - 1
        let newActText = customAct[index]
        customAct.remove(at: index)
        if (updateActivity.contains(newActText)) {
            index = updateActivity.index(of: newActText)!
            updateActivity.remove(at: index)
        }
        self.tableView.deleteRows(at: [newItemIndexPath], with: UITableViewRowAnimation.automatic)
        new -= 1
        self.tableView.endUpdates()
    }
    
    
    
//    @IBOutlet var activityText: UITextField!
    
//    // Hide keyboard when "Done" preseed and save new activity to array
//    @IBAction func resignKeyboard(_ sender: AnyObject) {
//        customAct.append(activityText.text!)
//        updateActivity.append(activityText.text!)
//        sender.resignFirstResponder()
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Default activity row
        if (indexPath.row < activities.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = activities[indexPath.row]
            let cellText = cell.textLabel?.text
            if (updateActivity.contains(cellText!)) {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
            } else {
                cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
            }
            return cell
        } else {
            // Added new activity row
            if (indexPath.row < (activities.count + new)) {
                let added = tableView.dequeueReusableCell(withIdentifier: "added", for: indexPath)
                added.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
                if (customAct.count > 0) {
                    print(indexPath.row)
                    print(activities.count)
                    added.textLabel?.text = customAct[indexPath.row - activities.count]
                }
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
        // Toggle selection circles
        if (indexPath.row < (activities.count + new)) {
            let currCell = tableView.cellForRow(at: indexPath)
            let string = (currCell?.textLabel!.text)!
            print(string)
            if (currCell?.accessoryType == UITableViewCellAccessoryType.checkmark) {
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
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
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
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
