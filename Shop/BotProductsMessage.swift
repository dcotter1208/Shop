//
//  BotProductsMessage.swift
//  Shop
//
//  Created by Donovan Cotter on 3/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

struct BotProductsMessage: MessageInfo {
    var messageType: MessageType
    var products: [Product]
}
