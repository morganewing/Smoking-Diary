//
//  ActivityViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 6/27/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit
import os.log

var customPeople = [String]()
// Number of custom activities
var newPeople = 0

class PeopleViewController: UITableViewController, UITextFieldDelegate {
    
    // Update activities when done button pressed
    @IBAction func doneButtonPeople(_ sender: Any) {
        if (updatePeople.count > 0) {
            currPeople = updatePeople
            if currPeople.contains("Add people") {
                currPeople.remove(at: 0)
            }
        }
        performSegue(withIdentifier: "peopleSegue", sender: self)
    }
    
    // Default list of activities
    var people = ["Friends", "Family", "Colleagues"]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (people.count + newPeople)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Default activity row
        let cellPeople = tableView.dequeueReusableCell(withIdentifier: "cellPeople", for: indexPath)
        cellPeople.textLabel?.text = people[indexPath.row]
        let cellText = cellPeople.textLabel?.text
        cellPeople.textLabel?.font = UIFont(name: "Halcom-Medium", size: 16)
        if (updatePeople.contains(cellText!)) {
            cellPeople.accessoryType = UITableViewCellAccessoryType.checkmark
            cellPeople.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
        } else {
            cellPeople.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
        }
        return cellPeople
    }
    
    // Add checkmarks and set currActivity to selected activity
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Toggle selection circles
        if (indexPath.row < (people.count + newPeople)) {
            let currCell = tableView.cellForRow(at: indexPath)
            if (currCell?.accessoryType == UITableViewCellAccessoryType.checkmark) {
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Disabled"))
                // Remove activity from list
                if (indexPath.row < people.count) {
                    if let itemToRemoveIndex = updatePeople.index(of: (currCell?.textLabel!.text)!) {
                        updatePeople.remove(at: itemToRemoveIndex)
                    }
                } else {
                    //remove custom activity!!!!
                }
            } else {
                currCell?.accessoryType = UITableViewCellAccessoryType.checkmark
                currCell?.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Selection circle Enabled"))
                // Add activity to list
                if (indexPath.row < people.count) {
                    updatePeople.append((currCell?.textLabel!.text)!)
                } else {
                     if (indexPath.row < (people.count + newPeople)) {
                        updatePeople.append(customAct[indexPath.row-people.count])
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
