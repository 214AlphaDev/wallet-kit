//
//  ConfirmMnemonicPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public class ConfirmMnemonicPresenter: EnterMnemonicPresenter, ConfirmMnemonicPresenterProtocol {
    
    public let wallet: Wallet
    
    public init(view: EnterMnemonicViewProtocol, wallet: Wallet) {
        self.wallet = wallet
        
        super.init(view: view)
        
        view.setMnemonicEnterObjective(.confirm)
    }
    
    public override func proceedMnemonic(_ mnemonic: Mnemonic) -> Response<Wallet> {
        if !wallet.equalMnemonic(to: mnemonic) {
            return .failure(ValidationError.mnemonicConfirmationMismatch)
        }
        
        return .success(wallet)
    }
    
}
