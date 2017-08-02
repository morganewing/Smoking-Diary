//
//  AddedActivityTableViewCell.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 7/12/17.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import UIKit

class AddedActivityTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityText.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var activityText: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activityText.resignFirstResponder()
        customAct.append(activityText.text!)
        updateActivity.append(activityText.text!)
        return true
    }
}
