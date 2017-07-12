//
//  ActivityViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 6/27/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit
import os.log

class ActivityViewController: UITableViewController {
    
    var updateActivity = [String]()
    
    // Update activites when done button pressed
    @IBAction func doneButton(_ sender: Any) {
        if (updateActivity.count > 0) {
            currActivity = updateActivity
        }
    }
    
    // Default list of activities
    var activities = ["Eating", "Drinking", "Coffee", "Driving", "Social"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count + 1
    }
    
    // Add custom activity when "Add" pressed
    @IBAction func addButton(_ sender: Any) {
        print("hey")
        activities.append("New Activity")
        self.tableView.beginUpdates()
        let newItemIndexPath = IndexPath(row: activities.count-1, section: 0)
        self.tableView.insertRows(at: [newItemIndexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row < activities.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = activities[indexPath.row]
            return cell
        } else {
            let custom = tableView.dequeueReusableCell(withIdentifier: "custom", for: indexPath)
            return custom
        }
    }
    
    // Add checkmarks and set currActivity to selected activity
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row <= 4) {
//            if currActivity.contains("Add activity") {
//                currActivity.remove(at: 0)
//            }
//            if currActivity.count == 1 {
//                currActivity.append("Add activity")
//            }
            let currCell = tableView.cellForRow(at: indexPath)
            if currCell?.accessoryType == UITableViewCellAccessoryType.checkmark {
                currCell?.accessoryType = UITableViewCellAccessoryType.none
                // Remove activity from list
                if let itemToRemoveIndex = updateActivity.index(of: (currCell?.textLabel!.text)!) {
                    updateActivity.remove(at: itemToRemoveIndex)
                }
            } else {
                currCell?.accessoryType = UITableViewCellAccessoryType.checkmark
                // Add activity to list
                updateActivity.append((currCell?.textLabel!.text)!)
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
