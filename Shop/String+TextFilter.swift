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
    
    func removeCommandWords() -> String {
        //Remove "search for" && "find"
        var newString = self
        var stringAsArray = self.components(separatedBy: " ")
        if stringAsArray[0] == "search" {
            stringAsArray.remove(at: 0)
        }
        
        if stringAsArray[0] == "for" {
            stringAsArray.remove(at: 0)
        }
        
        newString = stringAsArray.joined(separator: " ")

        return newString
    }
    
    func textNouns() -> [String] {
        let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation , .omitOther, .joinNames]
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: Int(options.rawValue))
        tagger.string = self
        var tokens = [(String, String?)]()
        var nouns = [String]()
        tagger.enumerateTags(in: NSMakeRange(0, self.characters.count), scheme: NSLinguisticTagSchemeLexicalClass, options: options) {
            (tag, tokenRange, _, _) in
            //get the token
            let token = (self as NSString).substring(with: tokenRange)
            tokens.append((token, tag))
        }
        let nounTokens = tokens.filter { $0.1 == "Noun" }
        for noun in nounTokens {
            nouns.append(noun.0)
        }
        return nouns
    }
    

}
