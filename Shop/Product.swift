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

struct Product {
    var name: String
    var UPC: String
    var description: String
    var price: String
    var rating: Float
    var imageURLs: [String]
    var similarItems: [Product]
    var isAvailableInStore: Bool
    var availableOnline: Bool
}
