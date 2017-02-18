//
//  ProductKeywords.swift
//  Shop
//
//  Created by Donovan Cotter on 2/12/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

//Use these keywords to search through the text and decide on what to search for. The goal is to be able to do 'KeywordSearch' structured as 'search=KEYWORD'.

//Use the 'bestBuyBrandNames' keywords to determine if there are keywords followed by one of the brand names. Then do a 'KeywordSearch'search for 'search=BRAND_NAME&search=KEYWORD'

fileprivate let bestBuyKeywords = ["computer",
                                   "laptop",
                                   "camera",
                                   "cell phone",
                                   "tablet",
                                   "hard drive",
                                   "storage",
                                   "vr",
                                   "memory",
                                   "office furniture",
                                   "antivirus",
                                   "battery",
                                   "music",
                                   "tv",
                                   "speaker",
                                   "monitor",
                                   "games",
                                   "videogames",
                                   "drones",
                                   "dvd",
                                   "cd",
                                   "oven",
                                   "microwave",
                                   "kitchen appliances",
                                   "refrigerator",
                                   "fridge",
                                   "range",
                                   "printer",
                                   "gps",
                                   "health",
                                   "wearable tech",
                                   "home office",
                                   "smart home",
                                   "drones",
                                   "speakers"]

fileprivate let bestBuyBrandNames = ["apple",
                                     "samsung",
                                     "sony",
                                     "microsoft",
                                     "intel",
                                     "lg",
                                     "insignia",
                                     "gopro",
                                     "bose",
                                     "canon",
                                     "epson",
                                     "nintendo",
                                     "sharp",
                                     "vizio",
                                     "whirlpool",
                                     "nikon"]

class ProductKeywords {
    class func getBestBuyKeywords() -> [String] {
        return bestBuyKeywords
    }
    
    class func getBestBuyBrandNames() -> [String] {
        return bestBuyBrandNames
    }
    
    

}
