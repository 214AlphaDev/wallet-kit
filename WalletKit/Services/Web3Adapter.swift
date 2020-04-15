//
//  Web3Adapter.swift
//  WalletKit
//
//  Created by Florian on 23.06.19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import web3swift
import BigInt
import PromiseKit

protocol Web3Adapter {
    func sendEther(from fromAddress: Address, to toAddress: Address, amount: BigUInt, gasPrice: TransactionSpeed) throws -> Promise<TransactionSendingResult>
    func getBalanceSync(of address: Address) throws -> BigUInt
    func getBalanceAsync(of adress: Address, callback: @escaping (Response<BigUInt>) -> Void)
}

class Web3AdapterImplementation: Web3Adapter {
    
    private let web3 : Web3
    
    init(keyStore: KeystoreManager, network: NetworkId, accessToken: String) {
        
        // you might wonder why web3 is initialized in a constructor. This is usually an anti pattern since it sucks to test it. However, this implementation can only be tested the hard way (functional tests) anyway. So it's fine here.
        let w3 = Web3(infura: network, accessToken: accessToken)
        w3.addKeystoreManager(keyStore)
        self.web3 = w3
        
    }
    
    func sendEther(from fromAddress: Address, to toAddress: Address, amount: BigUInt, gasPrice: TransactionSpeed) throws -> Promise<TransactionSendingResult> {
        var txOptions = Web3Options()
        txOptions.gasPrice = gasPrice.toWei()
        txOptions.from = fromAddress
        return try self.web3.eth.sendETH(to: toAddress, amount: amount, extraData: Data(), options: txOptions).sendPromise()
    }
    
    func getBalanceSync(of address: Address) throws -> BigUInt {
        return try self.web3.eth.getBalance(address: address)
    }
    
    func getBalanceAsync(of address: Address, callback: @escaping (Response<BigUInt>) -> Void) {
        self.web3.eth.getBalancePromise(address: address)
            .get { balance in
                callback(.success(balance))
            }.catch { error in
                callback(.failure(error))
        }
    }
    
}
