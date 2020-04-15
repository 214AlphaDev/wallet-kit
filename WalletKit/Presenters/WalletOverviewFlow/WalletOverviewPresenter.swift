//
//  WalletOverviewPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit
import web3swift
import BigInt

public class WalletOverviewPresenter: WalletOverviewPresenterProtocol {
    
    public var delegate: WeakWrapper<WalletOverviewPresenterDelegate> = WeakWrapper()
    public let view: WalletOverviewViewProtocol
    private let wallet: Wallet
    private let ethereumPriceService: EthereumPriceServiceProtocol
    
    public init(view: WalletOverviewViewProtocol, wallet: Wallet, ethereumPriceService: EthereumPriceServiceProtocol) {
        self.view = view
        self.wallet = wallet
        self.ethereumPriceService = ethereumPriceService
        
        view.presenter = WeakWrapper(self)
        
        passBalanceToView()
        refreshBalance()
    }
    
    public func goToSendEther() {
        do {
            try delegate.wrapped?.presenter(self, requestNavigateToSendEtherWith: wallet)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func goToReceiveEther() {
        do {
            try delegate.wrapped?.presenter(self, requestNavigateToReceiveEtherWith: wallet)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func refreshBalance() {
        view.setLoadingIndicatorVisible(true)
        wallet.refreshBalanceAsync { response in
            self.view.setLoadingIndicatorVisible(false)
            switch response {
            case .success(let balance):
                self.passBalanceToView(balance)
            case .failure(let error):
                self.view.displayError(title: "Error", error: error)
            }
        }
        updateETHUSDRate()
    }
    
    private func updateETHUSDRate() {
        ethereumPriceService.refreshUSDPrice { response in
            DispatchQueue.main.async {
                switch response {
                case .failure(let error):
                    self.view.displayError(title: "Error", error: error)
                case .success(_):
                    self.passBalanceToView()
                }
            }
        }
    }
    
    func passBalanceToView(_ providedBalance: BigUInt? = nil) {
        if let balance = providedBalance ?? wallet.balance() {
            view.displayETHBalance("\(balance.string(units: .eth)) ETH")
            
            if let rate = ethereumPriceService.currentUSDPrice() {
                view.displayUSDBalance(CurrencyConverter.convert(eth: balance, toUSDWith: rate))
            }
        }
    }
    
    
    // MARK: ViewControllerProvider
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
