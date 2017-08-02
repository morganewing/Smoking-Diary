//
//  UserEntriesTableViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 7/19/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit

var entDate = ""
var entCigs = -1
var entActivity = [String]()
var entLocation = [String]()
var entPeople = [String]()
var entMood = [String]()
var entId = -1

class UserEntriesTableViewController: UITableViewController {
    
    var entries: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let networkManager = NetworkManager()
        
        //username hardcoded
        networkManager.listEntries(for: "Morgan")  { entries in
            self.entries = entries
            edit = 0
            self.tableView.reloadData()
        }
        
        entDate = ""
        entCigs = -1
        entActivity = [String]()
        entLocation = [String]()
        entPeople = [String]()
        entMood = [String]()
        currActivity = ["Add activity"]
        currLocation = ["Add location"]
        currPeople = ["Add people"]
        currMood = ["Add mood"]
        updateActivity = currActivity
        updateLocation = currLocation
        updatePeople = currPeople
        updateMood = currMood
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of rows = number of entries
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true

    }
    
    // Set up rows with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entryCell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let date = entries[indexPath.row].date
        entryCell.textLabel?.text = date
        return entryCell
    }
    

    // Slide to delete entry
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let id = entries[indexPath.row].uniqueId
            let networkManager = NetworkManager()
            //Username hardcoded
            networkManager.deleteEntry(username: "Morgan", uniqueId: id) { (success, error) in
                //
            }
            entries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // Edit selected entry, perform segue to view controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uniqueId = entries[indexPath.row].uniqueId
        let networkManager = NetworkManager()
        networkManager.getEntry(username: "Morgan", uniqueId: uniqueId)  { getEntry in
            //
            entDate = getEntry[0].date
            entCigs = getEntry[0].numcig
            entActivity = getEntry[0].activity
            entLocation = getEntry[0].location
            entPeople = getEntry[0].people
            entMood = getEntry[0].mood
            entId = getEntry[0].uniqueId
        }
        edit = 1
        editInital = 1
        print(edit)
        performSegue(withIdentifier: "editEntry", sender: nil)
    }
}
