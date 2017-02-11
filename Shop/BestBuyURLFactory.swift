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
        //UPC returns an array of "products" that contains a dictionary with the product info in it. 
        return "https://api.bestbuy.com/v1/products(upc=\(UPC))?format=json&show=sku,name,salePrice,accessories.sku&apiKey=\(apiKey!)"
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
    func URLForKeywordSearch(searchText: String) -> String {
        //**Zip Code will be replaced by the user's location.
        
        let filteredSearchtext = createSearchableText(fromText: searchText)
        
        return "https://api.bestbuy.com/v1/stores(area(48038,50))+products(\(filteredSearchtext))?format=json&show=storeId,name,products.sku,products.name&apiKey=\(apiKey!)"
    }
    
    fileprivate func createSearchableText(fromText text: String) -> String {
        let punctuationToRemove = [".", "#","$", "*", "!", "(", ")", "()", "%", "@", "^", "+", "=", ":", ";", ",", "/", "_"]
        let newString = text.filterOutPunctuations(punctuations: punctuationToRemove)
            
//        newString.removeCommandWords()

        //1. *IF* the text contains a specified Best Buy Cateogies then search for that
        
        //2. *ELSE* put the &search='word'
        let qualifiedString = produceQualifiedTextSearchString(string: newString.removeCommandWords())
        return qualifiedString
    }
    
    fileprivate func produceQualifiedTextSearchString(string: String) -> String {
        return "search=\(string)".replacingOccurrences(of: " ", with: "&search=")
    }
    
}



