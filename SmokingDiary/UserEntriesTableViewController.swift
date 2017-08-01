//
//  UserEntriesTableViewController.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 7/19/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit

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
            self.tableView.reloadData()
            print(entries)
        }
        
       // tableView.allowsSelectionDuringEditing = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of rows = number of entries
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.tableView.beginUpdates()
        if editingStyle == .delete {
            let id = entries[indexPath.row].uniqueId
            let networkManager = NetworkManager()
            //Username hardcoded
            networkManager.deleteEntry(username: "Morgan", uniqueId: id) { (success, error) in
                //
            }
            entries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(entries.count)
        }
        self.tableView.endUpdates()
    }
    
    // Set up rows with data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entryCell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let date = entries[indexPath.row].date
        entryCell.textLabel?.text = date
        entryCell.accessoryType = UITableViewCellAccessoryType.checkmark
        entryCell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "Delete Activity"))
        return entryCell
    }
    
    // Edit selected entry
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uniqueId = entries[indexPath.row].uniqueId
        let networkManager = NetworkManager()
        networkManager.getEntry(username: "Morgan", uniqueId: uniqueId)  { entry in
            //
            self.entry = entry
        }
        print(entry.date)
    }
    
    // Delete selected entry
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Toggle selection circles
//        self.tableView.beginUpdates()
//        let indexArray = [indexPath]
//        self.tableView.deleteRows(at: indexArray, with: UITableViewRowAnimation.automatic)
//        let uniqueId = entries[indexPath.row].uniqueId
//        let networkManager = NetworkManager()
//        //Username hardcoded
//        networkManager.deleteEntry(username: "Morgan", uniqueId: uniqueId) { (success, error) in
//            //
//        }
//        entries.remove(at: indexPath.row)
//        self.tableView.endUpdates()
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
