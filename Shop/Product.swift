//
//  Product.swift
//  Shop
//
//  Created by Donovan Cotter on 2/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit
/*******
 Break this up into a Product protocol.
 *******/


enum ProductType {
    case kProductTypeBestBuy
}

struct Product {
    var name: String
    var UPC: String
    var description: String
    var regPrice: String
    var salePrice: String
    var rating: String
    var displayImage: String
    var imageURLs: [String]
    var similarProducts: [Product]?
    var isAvailableInStore: Bool
    var isAvailableOnline: Bool
}
