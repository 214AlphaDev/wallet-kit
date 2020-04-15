//
//  RestoreMnemonicFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol RestoreMnemonicFlowProtocol: Flow {}

public struct RestoreMnemonicFlowFactory {
    
    public static func build(restoreMnemonicPresenter: RestoreMnemonicPresenterProtocol) -> RestoreMnemonicFlowProtocol {
        
        return RestoreMnemonicFlow(restoreMnemonicPresenter: restoreMnemonicPresenter)
    }
    
}

class RestoreMnemonicFlow: SingleScreenFlow, RestoreMnemonicFlowProtocol, EnterMnemonicPresenterDelegate {
    
    init(restoreMnemonicPresenter: RestoreMnemonicPresenterProtocol) {
        super.init(presenter: restoreMnemonicPresenter)
        
        restoreMnemonicPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: EnterMnemonicPresenterDelegate
    
    func presenter(_ presenter: EnterMnemonicPresenterProtocol, requestNavigateToWalletWith wallet: Wallet) throws {
        try handle(action: DisplayWalletFlowAction(wallet: wallet))
    }
    
}
