//
//  Wallet.swift
//  WalletKit
//
//  Created by Florian on 21.06.19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import web3swift
import BigInt

final public class Wallet {
    
    public let mnemonic : Mnemonic
    private(set) public var ethBalance : BigUInt?
    let web3 : Web3Adapter
    public let address : Address
    
    public init(mnemonic: Mnemonic, network: NetworkId, infuraAccessToken: String) throws {
                
        self.mnemonic = mnemonic
    
        // Convert internal mnemonic value object to external Mnemonics type from web3 library.
        let web3Mnemonic = try Mnemonics(String(describing: mnemonic))
        
        // related to using ethereum
        let keyStore = try BIP32Keystore(mnemonics: web3Mnemonic)
        self.address = keyStore.addresses.first!
        self.web3 = Web3AdapterImplementation(keyStore: KeystoreManager([keyStore]), network: network, accessToken: infuraAccessToken)
    
    }
    
    public func equalMnemonic(to mnemonic: Mnemonic) -> Bool {
        return mnemonic == self.mnemonic
    }
    
    /// Gets new balance in a synchrounous way. WARNING: Blocking network request
    public func refreshBalanceSync() throws {
        self.ethBalance = try self.web3.getBalanceSync(of: self.address)
    }
    
    public func refreshBalanceAsync(callback: @escaping (Response<BigUInt>) -> Void) {
        self.web3.getBalanceAsync(of: self.address, callback: callback)
    }
    
    // balance might be
    public func balance() -> BigUInt? {
        return self.ethBalance
    }

    public func send(to: Address, amount: BigUInt, speed: TransactionSpeed, callback: @escaping (Response<Void>) -> Void) throws {
        try self.web3.sendEther(from: self.address, to: to, amount: amount, gasPrice: speed).get{ result in
            print(result)
            callback(.success(()))
        }.catch { error in
            callback(.failure(error))
        }
    }
    
    public static func factory(network: NetworkId, infuraAccessToken: String) throws -> Wallet {
        let web3Mnemonic = Mnemonics(entropySize: .b128, language: .english)
        // Convert external Mnemonics type to internal value object type.
        let mnemonic = try Mnemonic(string: web3Mnemonic.string)
        
        return try Wallet(mnemonic: mnemonic, network: network, infuraAccessToken: infuraAccessToken)
    }
    
}
