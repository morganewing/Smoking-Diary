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

class NetworkManager {

    let API_URL = "https://wt-96a40030c5d2a13282018030d32db7a4-0.run.webtask.io/back"
//    let dateFormatter: DateFormatter = {
//        $0.dateFormat = "MMMM dd, yyyy"
//        return $0
//    }(DateFormatter())
    let username = "Morgan"
    
    func saveEntry(dateTime: String, numCigs: Int, activityList: [String], locationList: [String], peopleList: [String], moodList: [String], completion: @escaping (_ success: Bool, _ error: NetworkError?) -> Void) {
        let parameters: Parameters = [
            "username": username,
            "date": dateTime,
            "numcig": numCigs,
            "activity": activityList,
            "location": locationList,
            "people": "Friend",
            "mood": "Happy"
        ]
    
        Alamofire.request(API_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            response in
            // check data
            completion(false, NetworkError.BadConnection)
            print(response)
        }
    }

}
