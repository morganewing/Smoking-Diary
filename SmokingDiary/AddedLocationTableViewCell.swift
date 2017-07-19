//
//  AddedActivityTableViewCell.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 7/12/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit

class AddedLocationTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet var newLocationText: UITextField!
    
    // Hide keyboard when "Done" preseed and save new activity to array
    @IBAction func resignKeyboard(_ sender: AnyObject) {
        customLocation.append(newLocationText.text!)
        newLocation += 1
        sender.resignFirstResponder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
