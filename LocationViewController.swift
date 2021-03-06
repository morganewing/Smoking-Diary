//
//  ActivityViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 6/27/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit
import os.log

// Global variables
var customLocation = [String]()
// Number of custom activities
var newLocation = 0

class LocationViewController: UITableViewController, UITextFieldDelegate {
    
    // Update activities when done button pressed
    @IBAction func doneButtonLocation(_ sender: Any) {
        if (updateLocation.count > 0) {
            currLocation = updateLocation
            if currLocation.contains("Add location") {
                currLocation.remove(at: 0)
            }
        }
        performSegue(withIdentifier: "locationSegue", sender: self)
    }
    
    // Default list of activities
    var locations = ["Home", "Work", "Restaurant", "Pub", "Cinema"]
    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (locations.count + newLocation)
    }
    
    // Set table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Default activity row
        let cellLocation = tableView.dequeueReusableCell(withIdentifier: "cellLocation", for: indexPath)
        cellLocation.textLabel?.text = locations[indexPath.row]
        cellLocation.textLabel?.font = UIFont(name: "Halcom-Medium", size: 16)
        let cellText = cellLocation.textLabel?.text
        if (updateLocation.contains(cellText!)) {
            cellLocation.accessoryType = UITableViewCellAccessoryType.checkmark
            cellLocation.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
        } else {
            cellLocation.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
        }
        return cellLocation
    }
    
    // Add checkmarks and set currActivity to selected activity
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Toggle selection circles
        if (indexPath.row < (locations.count + newLocation)) {
            let currCell = tableView.cellForRow(at: indexPath)
            if (currCell?.accessoryType == UITableViewCellAccessoryType.checkmark) {
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
                // Remove activity from list
                if (indexPath.row < locations.count) {
                    if let itemToRemoveIndex = updateLocation.index(of: (currCell?.textLabel!.text)!) {
                        updateLocation.remove(at: itemToRemoveIndex)
                    }
                } else {
                    // Remove custom activity
                }
            } else {
                currCell?.accessoryType = UITableViewCellAccessoryType.checkmark
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
                // Add activity to list
                if (indexPath.row < locations.count) {
                    updateLocation.append((currCell?.textLabel!.text)!)
                } else {
                     if (indexPath.row < (locations.count + newLocation)) {
                        updateLocation.append(customAct[indexPath.row-locations.count])
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
