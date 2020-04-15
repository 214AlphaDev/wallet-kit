//
//  WalletOverview+MVP.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/21/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol WalletOverviewPresenterDelegate: class {
    
    func presenter(_ presenter: WalletOverviewPresenterProtocol, requestNavigateToSendEtherWith wallet: Wallet) throws
    func presenter(_ presenter: WalletOverviewPresenterProtocol, requestNavigateToReceiveEtherWith wallet: Wallet) throws
    
}

public protocol WalletOverviewPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<WalletOverviewPresenterDelegate> { get set }
    var view: WalletOverviewViewProtocol { get }
    
    func goToSendEther()
    func goToReceiveEther()
    func refreshBalance()
    
}

public protocol WalletOverviewViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<WalletOverviewPresenterProtocol> { get set }
    
    func displayETHBalance(_ balanceString: String)
    func displayUSDBalance(_ balanceString: String)
    
}
