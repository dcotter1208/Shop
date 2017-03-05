//
//  BotHub.swift
//  Shop
//
//  Created by Donovan Cotter on 3/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

typealias BotResponse = (String?, [Product]?) -> Void

class BotHub {
    func keywordSearchResponse(forSearchText text: String, forBusiness business: Business, botResponse: @escaping BotResponse) {
        switch business.name {
        case "Best Buy":
            bestBuyKeywordResponse(keywordSearchText: text, botResponse: { (error, products) in
                guard let safeProducts = products else { return } //Supply Error Message
                botResponse(nil, safeProducts)
            })
        default:
            print("")
        }
    }
    
    fileprivate func bestBuyKeywordResponse(keywordSearchText text: String, botResponse: @escaping BotResponse) {
        let productNetworking = ProductNetworking()
        let keywordSearchURL = BestBuyURLFactory().URLForKeywordSearch(searchText: text.removeCommandWords().removeStopWords())
        AlamoOperation.requestWithURL(URL: keywordSearchURL) { (json, error) in
            
            guard let safeJSON = json else {
                botResponse("GENERIC ERROR MESSAGE", nil)
                return
            }
            
            let products = productNetworking.createProducts(forProductType: .kProductTypeBestBuy, json: safeJSON)
            botResponse(nil, products)
        }
    }
    
}
