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
    
    func process(message: Message) -> String {
        
        let punctuationToRemove = [".", "#","$", "*", "!", "(", ")", "()", "%", "@", "^", "+", "=", ":", ";", ",", "/", "_"]
        
        guard let text = message.text else {
            return genericResponse
        }
        
        let filteredText = text.filterOutPunctuations(punctuations: punctuationToRemove).removeCommandWords().removeStopWords()
        
        return constructResponse(text: filteredText)
    }
    
    //Use to determine response type.
    
    //Need a Response Construction Class that'll be able to construct all sorts of messages, including ones that return multiple product recommendations.
    fileprivate func constructResponse(text: String) -> String {
        guard text != "" else {
            return genericResponse
        }
        return keywordResponse()
    }

    //Responses
    fileprivate func keywordResponse() -> String {
        return ""
    }
    
    //other responses would be recommendation response, accessories, deals, etc.

}
