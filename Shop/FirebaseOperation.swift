//
//  FirebaseOperation.swift
//  Shop
//
//  Created by Donovan Cotter on 2/26/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class FirebaseOperation {
    let firebaseDatabaseRef = Database.database().reference()
    
    //Creates a new value for a specified child
    func save(userMessage message: TextOnlyMessage) {
        let childRef = firebaseDatabaseRef.child("messages").childByAutoId()
        childRef.setValue(map(userMessage: message))
    }

    //Queries a Firebase child without constraints.
    func query(child: String, firebaseDataEventType: DataEventType, completion: @escaping (_ result: DataSnapshot) -> Void) {
        let childRef = firebaseDatabaseRef.child(child)
        childRef.observe(firebaseDataEventType) {
            (snapshot) in
            completion(snapshot)
        }
    }
    
    
    //MARK: Helper Methods
    fileprivate func map(userMessage message: TextOnlyMessage) -> [String : String] {
        var firebaseMessage = [String : String]()
        firebaseMessage["text"] = message.text
        firebaseMessage["messageType"] = MessageType.userTextOnly.rawValue
        firebaseMessage["userID"] = CurrentUser.sharedInstance.userID
    
        return firebaseMessage
    }
    
    
}
