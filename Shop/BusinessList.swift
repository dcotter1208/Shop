//
//  BusinessList.swift
//  Shop
//
//  Created by Donovan Cotter on 2/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation



class BusinessList {
    
    class func getAllBusinesses() -> [Business] {
        let bestBuy = Business(name: "Best Buy", logo: #imageLiteral(resourceName: "best_buy_logo"))
        let businesses = [bestBuy]
        return businesses
    }
}
