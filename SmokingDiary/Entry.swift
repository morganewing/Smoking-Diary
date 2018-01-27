//
//  Entry.swift
//  SmokingDiary
//
//  Created by Morgan Ewing on 26/07/2017.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

// Class for smoking diary entry
class Entry {
    let username: String
    let date: String
    let numcig: Int
    let activity: [String]
    let location: [String]
    let people: [String]
    let mood: [String]
    let uniqueId: Int
    
    init(username: String, date: String, numcig: Int, activity: [String], location: [String], people: [String], mood: [String], uniqueId: Int) {
        self.username = username
        self.date = date
        self.numcig = numcig
        self.activity = activity
        self.location = location
        self.people = people
        self.mood = mood
        self.uniqueId = uniqueId
    }
}
