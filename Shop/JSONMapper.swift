//
//  JSONMapper.swift
//  Shop
//
//  Created by Donovan Cotter on 2/8/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation
import SwiftyJSON

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

fileprivate var bestBuyDictProductDict = [kBestBuyProductName                 : "",
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
    
    func createProduct(forProductType productType: ProductType, json: [String : Any]) -> Product {
        
        switch productType {
        case .bestBuy:
            return createBestBuyProduct(json: json)
        }
    }

    fileprivate func createBestBuyProduct(json: [String : Any]) -> Product {
        var product = Product(name: "", UPC: "", description: "'", regPrice: "", salePrice: "", rating: "", displayImage: "", imageURLs: [""], similarProducts: nil, isAvailableInStore: false, isAvailableOnline: false)
        let json = JSON(json)
        if let name = json[kBestBuyProductName].string {
            product.name = name
        }
        
        if let UPC = json[kBestBuyProductUPC].string {
            product.UPC = UPC
        }
        
        if let description = json[kBestBuyProductDescription].string {
            product.description = description
        }
        
        if let regPrice = json[kBestBuyProductRegPrice].rawString() {
            product.regPrice = regPrice
        }
        
        if let salePrice = json[kBestBuyProductSalePrice].rawString() {
            product.salePrice = salePrice
        }
        
        if let rating = json[kBestBuyProductRating].rawString() {
            product.rating = rating
        }
        
        if let image = json[kBestBuyProductDisplayImage].string {
            product.displayImage = image
        }
        
//        if let relatedProduct = json[kBestBuyProductRelatedProducts].array {
//            //Map related products by taking the related products JSON map those into 'Product' objects
////            product.similarProducts = 
//        }
        
        if let inStoreAvailability = json[kBestBuyProductInStoreAvailability].rawString() {
            if inStoreAvailability == "true" {
                product.isAvailableInStore = true
            } else {
                product.isAvailableInStore = false
            }
        }
        
        if let isAvailableOnline = json[kBestBuyProductOnlineAvailability].rawString() {
            if isAvailableOnline == "true" {
                product.isAvailableOnline = true
            } else {
                product.isAvailableOnline = false
            }
        }
        
        return product
    }
    
}
