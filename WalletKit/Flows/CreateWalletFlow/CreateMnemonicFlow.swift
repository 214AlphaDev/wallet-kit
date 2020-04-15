//
//  CreateMnemonicFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol CreateMnemonicFlowProtocol: Flow {}

public struct CreateMnemonicFlowFactory {
    
    public static func build(createMnemonicPresenter: CreateMnemonicPresenterProtocol) -> CreateMnemonicFlowProtocol {
        
        return CreateMnemonicFlow(createMnemonicPresenter: createMnemonicPresenter)
    }
    
}

class CreateMnemonicFlow: SingleScreenFlow, CreateMnemonicFlowProtocol, CreateMnemonicPresenterDelegate {
    
    init(createMnemonicPresenter: CreateMnemonicPresenterProtocol) {
        super.init(presenter: createMnemonicPresenter)
        
        createMnemonicPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: CreateMnemonicPresenterDelegate
    
    func presenter(_ presenter: CreateMnemonicPresenterProtocol, requestNavigateToMnemonicConfirmationWith wallet: Wallet) throws {
        try handle(action: DisplayConfirmMnemonicFlowAction(wallet: wallet))
    }
    
}
