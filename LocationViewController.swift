//
//  ActivityViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 6/27/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit
import os.log

var customLocation = [String]()
// Number of custom activities
var newLocation = 0

class LocationViewController: UITableViewController, UITextFieldDelegate {
    
    var updateLocation = [String]()
    
    // Update activities when done button pressed
    @IBAction func doneButtonLocation(_ sender: Any) {
        if (updateLocation.count > 0) {
            currLocation = updateLocation
        }
        print(currLocation)
    }
    
    // Default list of activities
    var locations = ["Home", "Work", "Restaurant", "Pub", "Cinema"]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (locations.count + newLocation)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Default activity row
        let cellLocation = tableView.dequeueReusableCell(withIdentifier: "cellLocation", for: indexPath)
        cellLocation.textLabel?.text = locations[indexPath.row]
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
                    //remove custom activity!!!!
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
