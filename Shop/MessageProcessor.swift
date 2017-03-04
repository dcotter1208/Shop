//
//  MessageProcessor.swift
//  Shop
//
//  Created by Donovan Cotter on 2/26/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

class MessageProcessor {
    
    fileprivate let genericResponse = "Sorry, I couldn't find what you were looking for. Please try rephrasing that."
    
    func process(message: Message, business: Business, botResponse: @escaping BotResponse) {
        
        let punctuationToRemove = [".", "#","$", "*", "!", "(", ")", "()", "%", "@", "^", "+", "=", ":", ";", ",", "/", "_"]
        
        guard let text = message.text else {
            botResponse(genericResponse, nil)
            return
        }
        
        guard text != "" else {
            botResponse(genericResponse, nil)
            return
        }
        
        switch message.messageType {
        case .userTextOnly:
            let filteredText = text.filterOutPunctuations(punctuations: punctuationToRemove).removeCommandWords().removeStopWords()
            keywordResponse(text: filteredText, business: business, botResponse: { (genericResponse, products) in
                guard let productArray = products else {
                    botResponse(self.genericResponse, nil)
                    return
                }
                botResponse(nil, productArray)
            })
            
        case .userProductQuery:
            print("Product Query Search")
        default:
            print("")
        }
    
    }

    //MARK: Responses
    fileprivate func keywordResponse(text: String, business: Business, botResponse: @escaping BotResponse) {
        BotHub().keywordSearchResponse(forSearchText: text, forBusiness: business) { (error, products) in
            guard let products = products else {
                botResponse(self.genericResponse, nil)
                return
            }
            botResponse(nil, products)
        }
    }
    
    //other responses would be recommendation response, accessories, deals, etc.

}
