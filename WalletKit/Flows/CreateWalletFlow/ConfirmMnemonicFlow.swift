//
//  ConfirmMnemonicFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol ConfirmMnemonicFlowProtocol: Flow {}

public struct ConfirmMnemonicFlowFactory {
    
    public static func build(confirmMnemonicPresenter: ConfirmMnemonicPresenterProtocol) -> ConfirmMnemonicFlowProtocol {
        
        return ConfirmMnemonicFlow(confirmMnemonicPresenter: confirmMnemonicPresenter)
    }
    
}

class ConfirmMnemonicFlow: SingleScreenFlow, ConfirmMnemonicFlowProtocol, EnterMnemonicPresenterDelegate {
    
    init(confirmMnemonicPresenter: ConfirmMnemonicPresenterProtocol) {
        super.init(presenter: confirmMnemonicPresenter)
        
        confirmMnemonicPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: EnterMnemonicPresenterDelegate
    
    func presenter(_ presenter: EnterMnemonicPresenterProtocol, requestNavigateToWalletWith wallet: Wallet) throws {
        try handle(action: DisplayWalletFlowAction(wallet: wallet))
    }
    
}
