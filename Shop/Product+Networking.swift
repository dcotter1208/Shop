//
//  Product+Networking.swift
//  Shop
//
//  Created by Donovan Cotter on 3/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

class ProductNetworking {
    func createProducts(forProductType productType: ProductType, json: [String : Any]) -> [Product] {
        let bestBuyNetworking = BestBuyNetworking()
        
        switch productType {
        case .kProductTypeBestBuy:
            return bestBuyNetworking.bestBuyKeywordSearchProducts(fromJSON: json)
        }
    }
}
