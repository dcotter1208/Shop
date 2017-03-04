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

typealias JSONResponse = ([String : Any]?, Error?) -> Void

class AlamoOperation {
    
    class func requestWithURL(URL: String, JSONResponse: @escaping JSONResponse) {
        Alamofire.request(URL).responseJSON {
            (response) in
            
            if let error = response.error {
                return JSONResponse(nil, error)
            }
            
            if let JSON = response.result.value {
                if let JSONDict = JSON as? [String : Any] {
                    JSONResponse(JSONDict, nil)
                }
            }
        }
    }
    
    class func imageDownload(imageURL: String) {
        
    }
    
}
