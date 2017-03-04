//
//  BestBuy+JSON.swift
//  Shop
//
//  Created by Donovan Cotter on 3/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    func bestBuyKeywordJSONResponse() -> [JSON]? {
        if let productJSON = self["stores"][0]["products"].array {
            return productJSON
        }
        return nil
    }
}
