//
//  NetworkManager.swift
//  SmokingDiary
//
//  Created by Lucas Gordon on 11/07/2017.
//  Copyright © 2017 Morgan Ewing. All rights reserved.
//

import Alamofire

enum NetworkError {
    case BadParameters
    case BadConnection
}

var editArray: NSArray! = []

class NetworkManager {

    typealias JSON = [String: Any]
   

    let API_URL = "https://wt-96a40030c5d2a13282018030d32db7a4-0.run.webtask.io/this"
    let username = "Morgan"
    
    func deleteEntry(username: String, uniqueId: Int, completion:  @escaping (_ entries: [Entry], _ error: NetworkError?) -> Void) {
        let parameters: Parameters = [
            "username": username,
            "method": "delete",
            "uniqueId": uniqueId
            
        ]
        Alamofire.request(API_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
        }

    }
        
        
    func listEntries(for username: String, completion: @escaping (_ entries: [Entry]) -> Void) {
        let parameters: Parameters = [
            "username": username,
            "method": "list"
        ]

        Alamofire.request(API_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success(let json):

                guard let _json = json as? JSON,
                    let entries = _json["entries"] as? [JSON] else {
                    completion([])
                    return
                }
                var entryObjects: [Entry] = []
                for entry in entries {
                    guard let username = entry["username"] as? String,
                        let date = entry["date"] as? String,
                        let numcig = entry["numcig"] as? Int,
                        let activity = entry["activity"] as? [String],
                        let location = entry["location"] as? [String],
                        let people = entry["people"] as? [String],
                        let mood = entry["mood"] as? [String],
                        let uniqueId = entry["uniqueId"] as? Int else {
                        continue
                    }
                    entryObjects.append(Entry(username: username, date: date, numcig: numcig, activity: activity, location: location, people: people, mood: mood, uniqueId: uniqueId))
                }
//                print(entryObjects)
                completion(entryObjects)
            case .failure(_):
                completion([])
            }
        }
    }

    func saveEntry(dateTime: String, numCigs: Int, activityList: [String], locationList: [String], peopleList: [String], moodList: [String], method: String, completion: @escaping (_ entries: [Entry], _ error: NetworkError?) -> Void) {
        let parameters: Parameters = [
            "username": username,
            "date": dateTime,
            "numcig": numCigs,
            "activity": activityList,
            "location": locationList,
            "people": peopleList,
            "mood": moodList,
            "method": "add"
            //add action
        ]
        
        //post method
    
        Alamofire.request(API_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            // check data
            
            //completion(false, NetworkError.BadConnection)
            
            print(response)
        }
    }
}
