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
    let firebaseDatabaseRef = FIRDatabase.database().reference()
    
    //Creates a new value for a specified child
    func save(userMessage message: Message) {
        let childRef = firebaseDatabaseRef.child("messages").childByAutoId()
        childRef.setValue(map(userMessage: message))
    }
    
    fileprivate func map(userMessage message: Message) -> [String : String] {
        var firebaseMessage = [String : String]()
        if let text = message.text {
            firebaseMessage["text"] = text
        }
        
        //Will only need to save the SKU because we'll perform a network request to get the product's details.
        if let sku = message.product?.SKU {
            firebaseMessage["sku"] = sku
            firebaseMessage["messageType"] = MessageType.userProductQuery.rawValue
        } else {
            firebaseMessage["messageType"] = MessageType.userTextOnly.rawValue
        }
        
        firebaseMessage["userID"] = CurrentUser.sharedInstance.userID
        
        return firebaseMessage
    }
    
    func save(botMessage message: Message) {
        
    }
    
}
