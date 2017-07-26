//
//  Entry.swift
//  SmokingDiary
//
//  Created by Lucas Gordon on 26/07/2017.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

class Entry {
    let username: String
    let date: String
    let numcig: Int
    init(username: String, date: String, numcig: Int) {
        self.username = username
        self.date = date
        self.numcig = numcig
    }
}
