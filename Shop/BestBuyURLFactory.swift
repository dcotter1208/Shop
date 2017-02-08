//
//  BestBuyURLFactory.swift
//  Shop
//
//  Created by Donovan Cotter on 2/5/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

class BestBuyURLFactory {
    
    let apiKey = KeyFactory().produceAPIKey(businessKey: .bestBuy)
    
    //Single product lookup with a UPC.
     func URLForProduct(UPC: String) -> String {
        return "https://api.bestbuy.com/v1/products(upc=\(UPC))?format=json&apiKey=\(apiKey!)"
    }
    
    func URLForProduct(SKU: String) -> String {
        return "https://api.bestbuy.com/v1/products/\(SKU).json?apiKey=\(apiKey!)"
    }
    
    //Related products based on a product's relatedProducts.sku attribute.
     func URLsForRelatedProducts(relatedSKUs: [String]) -> [String] {
        var URLS = [String]()
        for SKU in relatedSKUs {
            let url = "https://api.bestbuy.com/v1/products/\(SKU).json?apiKey=\(apiKey)"
            URLS.append(url)
        }
        return URLS
    }
    
    //A product's accessories based on a product's accessories.sku attribute.
    func URLsForProductAccessories(accessorySKUs: [String]) -> [String] {
        var URLS = [String]()
        for SKU in accessorySKUs {
            let url = "https://api.bestbuy.com/v1/products/\(SKU).json?apiKey=\(apiKey)"
            URLS.append(url)
        }
        return URLS
    }
    
    /*
     Also viewed: used to identify top ten products that were viewed along with the originating
     product. These results are determined based on aggregated customer browsing behavior over 
     the past thirty days on BESTBUY.COM.
    */
    func URLForAlsoView(productSKU: String) -> String {
        return "https://api.bestbuy.com/beta/products/\(productSKU)/alsoViewed?apiKey=\(apiKey)"
    }
    
    //Similar Products
    func URLForSimilarProducts(productSKU: String) -> String {
        return "https://api.bestbuy.com/beta/products/\(productSKU)/similar?apiKey=\(apiKey)"
    }
    
    //
    func URLForKeywordSearch(keywords: [String]) -> String {
        //Sample search query from BestBuy Docs: search=oven&search=stainless&search=steel
        //Using Natural Language Processing, the search string will have to be searched through to eliminate unneccessary words
        //A possible solution is to ask the user to only search for things such as "ovens", "cameras", "TVs", etc.
        
        let searchQuery = ""
        
        return "https://api.bestbuy.com/v1/products(\(searchQuery))?format=json&show=sku,name,salePrice&apiKey=\(apiKey)"
    }
    
}



