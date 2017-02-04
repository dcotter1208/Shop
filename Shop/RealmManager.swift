//
//  RealmManager.swift
//  Shop
//
//  Created by Donovan Cotter on 2/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
            print("realm**: \(realm?.configuration.fileURL)")
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func write(_ object:Object) {
        realm?.beginWrite()
        realm?.add(object)
        do {
            try realm?.commitWrite()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getRealmObjects(objectType: Object.Type) -> Results<Object>? {
        let realmResults = realm?.objects(objectType)
        if let results = realmResults {
            return results
        } else {
            return nil
        }
    }

    func setCurrentUserProfileWithRealm() {
        let realmResults = realm?.objects(RealmCurrentUser.self)
        if let results = realmResults {
            if results.count > 0 {
                CurrentUser.sharedInstance.setCurrentUserWithRealm(results: results)
            } else {
                createNewUser()
            }
        }
    }
    
    fileprivate func createNewUser() {
        let newRealmUser = RealmCurrentUser()
        newRealmUser.createUser()
        self.write(newRealmUser)
    }
    
}
