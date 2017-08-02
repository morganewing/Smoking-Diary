//
//  ActivityViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 6/27/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit
import os.log

var customMood = [String]()
// Number of custom activities
var newMood = 0

class MoodViewController: UITableViewController, UITextFieldDelegate {
    
    // Update activities when done button pressed
    @IBAction func doneButtonMood(_ sender: Any) {
        if (updateMood.count > 0) {
            currMood = updateMood
            if currMood.contains("Add mood") {
                currMood.remove(at: 0)
            }
        }
    }
    
    // Default list of activities
    var moods = ["Happy", "Sad", "Angry", "Stressed"]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (moods.count + newMood)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Default activity row
        let cellMood = tableView.dequeueReusableCell(withIdentifier: "cellMood", for: indexPath)
        cellMood.textLabel?.text = moods[indexPath.row]
        let cellText = cellMood.textLabel?.text
        cellMood.textLabel?.font = UIFont(name: "Halcom-Medium", size: 16)
        if (updateMood.contains(cellText!)) {
            cellMood.accessoryType = UITableViewCellAccessoryType.checkmark
            cellMood.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
        } else {
            cellMood.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
        }
        return cellMood
    }
    
    // Add checkmarks and set currActivity to selected activity
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Toggle selection circles
        if (indexPath.row < (moods.count + newMood)) {
            let currCell = tableView.cellForRow(at: indexPath)
            if (currCell?.accessoryType == UITableViewCellAccessoryType.checkmark) {
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
                // Remove activity from list
                if (indexPath.row < moods.count) {
                    if let itemToRemoveIndex = updateMood.index(of: (currCell?.textLabel!.text)!) {
                        updateMood.remove(at: itemToRemoveIndex)
                    }
                } else {
                    //remove custom activity!!!!
                }
            } else {
                currCell?.accessoryType = UITableViewCellAccessoryType.checkmark
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
                // Add activity to list
                if (indexPath.row < moods.count) {
                    updateMood.append((currCell?.textLabel!.text)!)
                } else {
                     if (indexPath.row < (moods.count + newMood)) {
                        updateMood.append(customAct[indexPath.row-moods.count])
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        for i in 0...activities.count {
//            print("u there")
//            let actCell = tableView.cellForRow(at: IndexPath(row: i, section: 0))
//            print(actCell)
//            actCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
//        }
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
