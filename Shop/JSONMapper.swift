//
//  JSONMapper.swift
//  Shop
//
//  Created by Donovan Cotter on 2/8/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

//Best Buy JSON Keys
fileprivate let kBestBuyProductName = "name"
fileprivate let kBestBuyProductUPC = "upc"
fileprivate let kBestBuyProductDescription = "longDescription"
fileprivate let kBestBuyProductRegPrice = "regularPrice"
fileprivate let kBestBuyProductSalePrice = "salePrice"
fileprivate let kBestBuyProductRating = "customerReviewAverage"
fileprivate let kBestBuyProductDisplayImage = "image"
fileprivate let kBestBuyProductRelatedProducts = "relatedProducts"
fileprivate let kBestBuyProductInStoreAvailability = "inStoreAvailability"
fileprivate let kBestBuyProductOnlineAvailability = "onlineAvailability"

fileprivate let bestBuyDictProductDict = [kBestBuyProductName                 : "",
                                          kBestBuyProductUPC                  : "",
                                          kBestBuyProductDescription          : "",
                                          kBestBuyProductRegPrice             : "",
                                          kBestBuyProductSalePrice            : "",
                                          kBestBuyProductRating               : "",
                                          kBestBuyProductDisplayImage         : "",
                                          kBestBuyProductRelatedProducts      : [String](),
                                          kBestBuyProductInStoreAvailability  : "",
                                          kBestBuyProductOnlineAvailability   : ""] as [String : Any]

class JSONMapper {
    
    func createProduct(forProductType productType: ProductType, JSON: NSDictionary) -> Product {
        
        let product =
        
        
    }
    
    fileprivate func createDictProductType(productType: ProductType) -> [String : Any] {
        switch productType {
        case .bestBuy:
            return bestBuyDictProductDict
        }
    }
    
    fileprivate func createBestBuyProduct(dict: [String : Any]) {
        if let name = dict[kBestBuyProductName] as? String {
            
        }
    }
    
}
