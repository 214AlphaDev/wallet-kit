//
//  ErrorDescription.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public struct ErrorDescription {
    
    public static func describe(error: Error) -> String? {
        guard let walletKitError = error as? WalletKitError else {
            return nil
        }
        
        return walletKitError.errorDescription
    }
    
}
