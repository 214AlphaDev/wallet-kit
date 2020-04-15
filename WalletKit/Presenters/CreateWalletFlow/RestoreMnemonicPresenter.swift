//
//  RestoreMnemonicPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public class RestoreMnemonicPresenter: EnterMnemonicPresenter, RestoreMnemonicPresenterProtocol {
    
    let walletFactory: (_ mnemonic: Mnemonic) throws -> Wallet
    
    public init(view: EnterMnemonicViewProtocol, walletFactory: @escaping (_ mnemonic: Mnemonic) throws -> Wallet) {
        self.walletFactory = walletFactory
        
        super.init(view: view)
        
        view.setMnemonicEnterObjective(.restore)
    }
    
    public override func proceedMnemonic(_ mnemonic: Mnemonic) -> Response<Wallet> {
        do {
            return .success(try walletFactory(mnemonic))
        } catch {
            return .failure(error)
        }
    }
    
}
