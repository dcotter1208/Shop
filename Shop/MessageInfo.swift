//
//  MessageInfo.swift
//  Shop
//
//  Created by Donovan Cotter on 3/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

enum MessageType: String {
    case userTextOnly
    case userProductQuery
    case botTextOnly
}

protocol MessageInfo {
    var messageType: MessageType { get set }
}
