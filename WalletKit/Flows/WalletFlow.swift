//
//  WalletFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol WalletFlowProtocol: Flow {}

public struct WalletFlowFactory {
    
    public static func build(
        rootViewController: UIViewController = UIViewController(),
        addWalletFlow: AddWalletFlowProtocol,
        walletOverviewFlowFactory: @escaping (Wallet) -> WalletOverviewFlowProtocol, walletRepository: WalletRepositoryProtocol) -> WalletFlowProtocol {
        let currentWallet = try? walletRepository.get()
        
        let rootFlow: Flow
        if let walletOptional = currentWallet, let wallet = walletOptional {
            rootFlow = walletOverviewFlowFactory(wallet)
        } else {
            rootFlow = addWalletFlow
        }
        
        let walletFlow = WalletFlow(viewController: rootViewController)
        walletFlow.setChildFlow(rootFlow)
        
        return FlowBuilder(rootFlow: walletFlow)
            .on(DisplayWalletFlowAction.self) { root, action in
                try walletRepository.save(action.wallet)
                 root.setChildFlow(walletOverviewFlowFactory(action.wallet))
            }
            .rootFlow
    }
    
}

public class WalletFlow: ContainerFlow, WalletFlowProtocol {}
