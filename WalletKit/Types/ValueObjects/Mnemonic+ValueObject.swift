//
//  Mnemonic+ValueObject.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public struct Mnemonic: CustomStringConvertible, Equatable {
    
    public let words: [String]
    
    public var description: String {
        return words.joined(separator: " ")
    }
    
    public init(words: [String], expectedLength: Int = Constants.mnemonicLength) throws {
        if words.count != expectedLength {
            throw ValidationError.invalidMnemonicWordsCount
        }
        
        for word in words {
            if case .invalid(let error) = Mnemonic.validateWord(word) {
                throw error
            }
        }
        
        self.words = words
    }
    
    public init(string: String) throws {
        let words = string.split(separator: " ").map(String.init)
        
        try self.init(words: words)
    }
    
    public static func validateWord(_ word: String) -> ValidationResult {
        return (word.range(of: "\\P{Latin}", options: .regularExpression) == nil) ? .valid : .invalid(ValidationError.invalidCharacterInMnemonicWord)
    }
    
}

