//
//  SpotsServices.swift
//  demo
//
//  Created by Casey Corvino on 11/15/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class SpotsServices{
    
    var ref: DatabaseReference! = Database.database().reference()
    
    func uploadSpot(lat: Double, lon: Double, userID: String, view: UIViewController){
        let helping = Helper()
        
        let key = ref.child("Spots").childByAutoId().key
        let post = ["owner": userID,
                    "dateCreated": helping.formatDate(date: Date()),
                    "latitude": lat,
                    "longitude": lon] as [String : Any]
        let childUpdates = ["/Spots/\(key)": post]
        
        ref.updateChildValues(childUpdates) { (error: Error?, dr: DatabaseReference) in
            let helping = Helper()
            if error != nil{
                helping.displayAlertOK(title: "Server Reported an Error", message: (error?.localizedDescription)!, view: view)
            } else {
                helping.displayAlertOK(title: "Success!", message: "Spot Uploaded Succesfully", view: view)
            }
        }
        
    }
    
    var spotsFeed:[Spot] = [];
    func retrieveSpots(completionHandler: @escaping () -> Void){
        spotsFeed = []
        ref.child("Spots").observe(.value, andPreviousSiblingKeyWith: { (ds: DataSnapshot, str: String?) in
            
            for child in ds.children {
                if let ch: DataSnapshot = child as? DataSnapshot{
                    let value = ch.value as? NSDictionary
                    let spot = Spot()
                    spot.dateCreated = value?.value(forKey: "dateCreated") as? String
                    spot.latitude = value?.value(forKey: "latitude") as? Double
                    spot.longitude = value?.value(forKey: "longitude") as? Double
                    spot.owner = value?.value(forKey: "owner") as? String
                    self.spotsFeed.append(spot)
                } else {
                    print("can't convert")
                }
            }
            completionHandler()
            print(self.spotsFeed)
        }) { (error: Error?) in
            if error != nil{
                print("ERROR ++++++++++++++++" + (error?.localizedDescription)!)
            }
        }
    }
    
    
    
}
