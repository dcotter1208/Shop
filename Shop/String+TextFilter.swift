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
    func remove(punctuations: [String]) -> String {
        var filteredString = self
        for punctuation in punctuations {
            if let puncChar = punctuation.characters.first {
                if self.characters.contains(puncChar) {
                    filteredString = filteredString.replacingOccurrences(of: punctuation, with: "")
                }
            }
        }
        return filteredString
    }
    
}
