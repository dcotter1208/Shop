//
//  Message.swift
//  Shop
//
//  Created by Donovan Cotter on 2/19/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

enum MessageType: String {
    case userTextOnly
    case userProductQuery
    case botTextOnly
}

struct Message {
    var text: String?
    var product: Product?
    var imagesURLs: [String]?
    var messageType: MessageType
}
