//
//  AddWalletFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol AddWalletFlowProtocol: Flow {}

public struct AddWalletFlowFactory {

    public static func build(
        navigationController: UINavigationController,
        walletLandingPresenter: WalletLandingPresenterProtocol,
        createMnemonicFlowFactory: @escaping () -> CreateMnemonicFlowProtocol,
        confirmMnemonicFlowFactory: @escaping (_ wallet: Wallet) -> ConfirmMnemonicFlowProtocol,
        restoreMnemonicFlowFactory: @escaping () -> RestoreMnemonicFlowProtocol) -> AddWalletFlowProtocol {
        let builder = FlowBuilder(rootFlow: AddWalletFlow(navigationController: navigationController, walletLandingPresenter: walletLandingPresenter))

        return builder
            .push(on: DisplayCreateMnemonicFlowAction.self) { _, _ in
                return createMnemonicFlowFactory()
            }
            .push(on: DisplayRestoreMnemonicFlowAction.self) { _, _ in
                return restoreMnemonicFlowFactory()
            }
            .push(on: DisplayConfirmMnemonicFlowAction.self) { _, action in
                return confirmMnemonicFlowFactory(action.wallet)
            }.pop(CreateMnemonicFlowProtocol.self)
            .pop(RestoreMnemonicFlowProtocol.self)
            .pop(ConfirmMnemonicFlowProtocol.self)
            .rootFlow
    }

}

public class AddWalletFlow: PushPopNavigationFlow, AddWalletFlowProtocol, WalletLandingPresenterDelegate {
    
    init(navigationController: UINavigationController, walletLandingPresenter: WalletLandingPresenterProtocol) {
        super.init(navigationController: navigationController, rootFlow: SingleScreenFlow(presenter: walletLandingPresenter))
        
        walletLandingPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: WalletLandingPresenterDelegate
    
    public func presenterRequestNavigateToMnemonicCreate(_ presenter: WalletLandingPresenterProtocol) throws {
        try handle(action: DisplayCreateMnemonicFlowAction())
    }
    
    public func presenterRequestNavigateToMnemonicRestore(_ presenter: WalletLandingPresenterProtocol) throws {
        try handle(action: DisplayRestoreMnemonicFlowAction())
    }
    
}
