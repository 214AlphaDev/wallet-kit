//
//  Errors.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

protocol WalletKitError: Error {
    var errorDescription: String { get }
}

enum GeneralError: WalletKitError {
    
    case unimplemented
    
    var errorDescription: String {
        switch self {
        case .unimplemented:
            return "This function lacks implementation. Please report this issue"
        }
    }
    
}

enum ValidationError: WalletKitError {
    case mnemonicConfirmationMismatch
    case invalidMnemonicWordsCount
    case invalidCharacterInMnemonicWord
    case invalidEmptyMnemonicWord
    case invalidAmountString
    case invalidAddressString
    
    var errorDescription: String {
        switch self {
        case .mnemonicConfirmationMismatch:
            return "Entered mnemonic does not match initial one"
        case .invalidMnemonicWordsCount:
            return "Entered mnemonic has incorrect length"
        case .invalidCharacterInMnemonicWord:
            return "Entered mnemonic word contains invalid characters"
        case .invalidEmptyMnemonicWord:
            return "Entered mnemonic word is incorrectly empty"
        case .invalidAmountString:
            return "Invalid amount string"
        case .invalidAddressString:
            return "Invalid address string"
        }
    }
}

enum ResponseError: WalletKitError {
    
    case failedToGetETHPrice
    
    var errorDescription: String {
        switch self {
        case .failedToGetETHPrice:
            return "Unable to get current ethereum price"
        }
    }
    
}

enum PersistenceError: WalletKitError {
    
    case walletPersistenceWithoutCurrentMember
    
    var errorDescription: String {
        switch self {
        case .walletPersistenceWithoutCurrentMember:
            return "Failed to persist wallet without current member"
        }
    }
    
    
}
