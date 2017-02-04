//
//  CurrentUser.swift
//  Shop
//
//  Created by Donovan Cotter on 2/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation
import RealmSwift

class CurrentUser {
    var userID = ""
    var botID = ""
    
    class var sharedInstance: CurrentUser {
        struct Singleton {
            static let instance = CurrentUser()
        }
        return Singleton.instance
    }
    
    
    func setCurrentUserWithRealm(results: Results<RealmCurrentUser>) {
        self.userID = results[0].userID
        self.botID = results[0].botID
    }

}
