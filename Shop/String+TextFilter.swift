//
//  Text+NLP.swift
//  Shop
//
//  Created by Donovan Cotter on 2/10/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import Foundation

extension String {
    
    //Removes a supplied array puncutations from a string and returns a new string.
    func filterOutPunctuations(punctuations: [String]) -> String {
        var filteredString = self.removeCommandWords()
        for punctuation in punctuations {
            if let puncChar = punctuation.characters.first {
                if self.characters.contains(puncChar) {
                    filteredString = filteredString.replacingOccurrences(of: punctuation, with: "")
                }
            }
        }
        return filteredString
    }
    
    func removeCommandWords() -> String {
        //Remove "search for" && "find"
        var newString = ""
        var stringAsArray = self.components(separatedBy: " ")
        if stringAsArray[0] == "search" {
            stringAsArray.remove(at: 0)
        }
        
        if stringAsArray[0] == "for" {
            stringAsArray.remove(at: 0)
        }
        
        newString = stringAsArray.joined(separator: " ")
            
//            && stringAsArray[1] == "for" {
//            stringAsArray.remove(at: 1)
//            stringAsArray.remove(at: 0)
//            return stringAsArray.joined(separator: " ")
//        }
        return newString
    }

}
