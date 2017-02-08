//
//  KeyFactory.swift
//  Shop
//
//  Created by Donovan Cotter on 2/8/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

enum BusinessKey: String {
    case bestBuy = "BestBuyAPI"
}

class KeyFactory {
    
    func produceAPIKey(businessKey: BusinessKey) -> String? {
        let plistKey = extractPlistKeyForBusiness(businessKey: businessKey)
        guard let keyList = produceKeyListDict() else { return nil }
        guard let key = keyList[plistKey] as? String else { return nil }
        return key
    }
    
    fileprivate func extractPlistKeyForBusiness(businessKey: BusinessKey) -> String {
        switch businessKey {
        case .bestBuy:
            return "BestBuyAPI"
        }
    }
    
    fileprivate func produceKeyListDict() -> NSDictionary? {
        if let plistPath = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let keyList = NSDictionary(contentsOfFile: plistPath) {
            return keyList
        }
        return nil
    }
    
    
}
