//
//  RealmUser.swift
//  Shop
//
//  Created by Donovan Cotter on 2/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCurrentUser: Object {
    dynamic var userID = ""
    dynamic var botID = ""
    
    override static func primaryKey() -> String? {
        return "userID"
    }
    
    func createUser() {
        self.userID = UUID().uuidString
        self.botID = UUID().uuidString
    }

}
