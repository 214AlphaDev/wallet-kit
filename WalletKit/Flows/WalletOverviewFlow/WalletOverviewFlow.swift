//
//  WalletOverviewFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol WalletOverviewFlowProtocol: Flow {}

public struct WalletOverviewFlowFactory {
    
    public static func build(walletOverviewPresenter: WalletOverviewPresenterProtocol, sendEtherFlowFactory: @escaping (Wallet) -> SendEtherFlowProtocol, receiveEtherFlowFactory: @escaping (Wallet) -> ReceiveEtherFlowProtocol) -> WalletOverviewFlowProtocol {
        let builder = FlowBuilder(rootFlow: WalletOverviewFlow(walletOverviewPresenter: walletOverviewPresenter))
        
        return builder.on(DisplaySendEtherFlowAction.self) { root, action in
                try root.present(sendEtherFlowFactory(action.wallet), animated: true)
            }.on(DisplayReceiveEtherFlowAction.self) { root, action in
                try root.present(receiveEtherFlowFactory(action.wallet), animated: true)
            }.on(CloseSendEtherFlowAction.self) { root, action in
                root.dismissPresenterFlow(animated: true)
            }.on(CloseReceiveEtherFlowAction.self) { root, action in
                root.dismissPresenterFlow(animated: true)
            }
            .rootFlow
    }
    
}

class WalletOverviewFlow: SingleScreenFlow, WalletOverviewFlowProtocol, WalletOverviewPresenterDelegate {
    
    init(walletOverviewPresenter: WalletOverviewPresenterProtocol) {
        super.init(presenter: walletOverviewPresenter)
        
        walletOverviewPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: WalletOverviewPresenterDelegate
    
    func presenter(_ presenter: WalletOverviewPresenterProtocol, requestNavigateToSendEtherWith wallet: Wallet) throws {
        try handle(action: DisplaySendEtherFlowAction(wallet: wallet))
    }
    
    func presenter(_ presenter: WalletOverviewPresenterProtocol, requestNavigateToReceiveEtherWith wallet: Wallet) throws {
        try handle(action: DisplayReceiveEtherFlowAction(wallet: wallet))
    }
    
}
