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
            let url = "https://api.bestbuy.com/v1/products/\(SKU).json?apiKey=\(String(describing: apiKey))"
            URLS.append(url)
        }
        return URLS
    }
    
    //A product's accessories based on a product's accessories.sku attribute.
    func URLsForProductAccessories(accessorySKUs: [String]) -> [String] {
        var URLS = [String]()
        for SKU in accessorySKUs {
            let url = "https://api.bestbuy.com/v1/products/\(SKU).json?apiKey=\(String(describing: apiKey))"
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
        return "https://api.bestbuy.com/beta/products/\(productSKU)/alsoViewed?apiKey=\(String(describing: apiKey))"
    }
    
    //Similar Products
    func URLForSimilarProducts(productSKU: String) -> String {
        return "https://api.bestbuy.com/beta/products/\(productSKU)/similar?apiKey=\(String(describing: apiKey))"
    }
    
    //Keyword Search
    func URLForKeywordSearch(searchText: String) -> String {
        //****Zip Code will be replaced by the user's location.***
        
        let filteredSearchtext = createSearchableText(fromText: searchText)

        return "https://api.bestbuy.com/v1/products((\(filteredSearchtext)))?apiKey=\(apiKey!)&format=json"
        
//        return "https://api.bestbuy.com/v1/stores(area(48038,50))+products(\(filteredSearchtext))?format=json&apiKey=\(apiKey!)"
//        /&show=storeId,name,products.sku,products.name,products.department
    }
    
    fileprivate func createSearchableText(fromText text: String) -> String {
        let punctuationToRemove = [".", "#","$", "*", "!", "(", ")", "()", "%", "@", "^", "+", "=", ":", ";", ",", "/", "_"]
        let newString = text.filterOutPunctuations(punctuations: punctuationToRemove)
        let qualifiedString = produceQualifiedTextSearchString(string: newString.removeCommandWords())
        
        //**IF** qualifiedString is only one word and contains one of the specified Best Buy categories then do a category search otherwise continue on with the text search.
        
        return qualifiedString
    }
    
    fileprivate func produceQualifiedTextSearchString(string: String) -> String {
        return "search=\(string)".replacingOccurrences(of: " ", with: "")
    }
    
    func URLForAllCategories() -> String {
        return "https://api.bestbuy.com/v1/categories?format=json&apiKey=\(apiKey!)"
    }
    
    func URLForProductCategory() -> String {
        return "https://api.bestbuy.com/v1/categories.json.zip?apiKey=\(apiKey!)"
    }

}



