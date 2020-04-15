//
//  WalletRepositoryProtocol.swift
//  WalletKit
//
//  Created by Florian on 23.06.19.
//  Copyright © 2019 214alpha. All rights reserved.
//

public protocol WalletRepositoryProtocol {
    // persist wallet
    func save(_ w: Wallet) throws
    // get wallet returns nil if wallet doesn't exist
    func get() throws -> Wallet?
}
