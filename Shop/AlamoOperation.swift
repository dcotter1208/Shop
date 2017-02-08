//
//  AlamoOperation.swift
//  Shop
//
//  Created by Donovan Cotter on 2/5/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class AlamoOperation {
    
    class func requestWithURL(URL: String) {
        Alamofire.request(URL).responseJSON {
            (response) in
            print("DATA: \(response.data)")
            print("Status Code: \(response.response?.statusCode)")
            print("ERROR: \(response.error)")
            
            if let JSON = response.result.value {
                let product = JSONMapper().createProduct(forProductType: .bestBuy, json: JSON as! [String : Any])
                print("PRODUCT****\(product)")
            }
            
        }
    }
    
    class func imageDownload(imageURL: String) {
        
    }
    
}
