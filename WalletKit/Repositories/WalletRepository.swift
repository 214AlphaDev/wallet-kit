//
//  WalletRepository.swift
//  WalletKit
//
//  Created by Florian on 23.06.19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import KeychainAccess
import web3swift
import CommunityKit

public class WalletRepository : WalletRepositoryProtocol {
    
    private let keychain: Keychain
    private let networkID: NetworkId
    private let infuraAccessToken: String
    private let memberService: MemberServiceProtocol
    
    public init(keychain: Keychain, networkID: NetworkId, infuraAccessToken: String, memberService: MemberServiceProtocol) {
        self.keychain = keychain
        self.networkID = networkID
        self.infuraAccessToken = infuraAccessToken
        self.memberService = memberService
    }
    
    public func save(_ w: Wallet) throws {
        guard let memberId = try memberService.getCurrentMember()?.id else {
            throw PersistenceError.walletPersistenceWithoutCurrentMember
        }
        
        try self.keychain.set(String(describing: w.mnemonic), key: persistenceKeyFor(memberId: memberId))
    }
    
    public func get() throws -> Wallet? {
        guard let memberId = try memberService.getCurrentMember()?.id else {
            // No current member, so return nil wallet
            return nil
        }
        
        guard let mnemonic = try self.keychain.get(persistenceKeyFor(memberId: memberId)) else {
            return nil
        }
        
        return try Wallet(mnemonic: Mnemonic(string: mnemonic), network: self.networkID, infuraAccessToken: self.infuraAccessToken)
    }
    
    func persistenceKeyFor(memberId: UUIDV4) -> String {
        let idString = String(describing: memberId)
        
        return "wallet-\(idString)"
    }
    
}
