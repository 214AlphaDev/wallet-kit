//
//  SendEtherPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit
import web3swift
import BigInt

public class SendEtherPresenter: SendEtherPresenterProtocol {
    
    public var delegate: WeakWrapper<SendEtherPresenterDelegate> = WeakWrapper()
    public let view: SendEtherViewProtocol
    private let wallet: Wallet
    private var ethAmountString: String = "0"
    private var usdAmountString: String = "0"
    private var addressString: String = ""
    private var transactionSpeed: TransactionSpeed = .high
    private let ethereumPriceService: EthereumPriceServiceProtocol
    
    public init(view: SendEtherViewProtocol, wallet: Wallet, ethereumPriceService: EthereumPriceServiceProtocol) {
        self.view = view
        self.wallet = wallet
        self.ethereumPriceService = ethereumPriceService
        
        view.presenter = WeakWrapper(self)
        view.setUSDFieldEnabled(false)
        view.displayETHAmountString(ethAmountString)
        updateETHUSDRate()
    }
    
    public func setETHAmountString(_ amountString: String) {
        ethAmountString = amountString
        
        if let ethAmount = BigUInt.init(ethAmountString, units: .eth), let rate = ethereumPriceService.currentUSDPrice() {
            usdAmountString = CurrencyConverter.convert(eth: ethAmount, toUSDWith: rate, displayCurrencySymbol: false)
            view.displayUSDAmountString(usdAmountString)
        }
    }
    
    public func setUSDAmountString(_ amountString: String) {
        usdAmountString = amountString
        
        if let usdAmount = BigUInt.init(usdAmountString, units: .eth), let rate = ethereumPriceService.currentUSDPrice() {
            ethAmountString = CurrencyConverter.convert(usd: usdAmount, toETHWith: rate, displayCurrencySymbol: false)
            view.displayETHAmountString(ethAmountString)
        }
    }
    
    public func setAddress(_ address: String) {
        self.addressString = address
    }
    
    public func setTransactionSpeed(_ speed: TransactionSpeed) {
        self.transactionSpeed = speed
    }
    
    public func validate(field: SendEtherValidationField) -> ValidationResult {
        switch field {
        case .address(let address):
            return web3swift.Address(address).isValid  ? .valid : .invalid(ValidationError.invalidAddressString)
        case .amountString(let amount):
            return BigUInt(amount, units: .eth) == nil ? .invalid(ValidationError.invalidAmountString) : .valid
        }
    }
    
    public func send() {
        view.setLoadingIndicatorVisible(true)
        do {
            let address = Address(addressString)
            if !address.isValid {
                throw ValidationError.invalidAddressString
            }
            guard let amount = BigUInt.init(ethAmountString, units: .eth) else {
                throw ValidationError.invalidAmountString
            }
            
            try wallet.send(to: address, amount: amount, speed: transactionSpeed) { response in
                self.view.setLoadingIndicatorVisible(false)
                switch response {
                case .failure(let error):
                    self.view.displayError(title: "Error", error: error)
                case .success():
                    self.close()
                }
            }
        } catch {
            view.setLoadingIndicatorVisible(false)
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func close() {
        do {
            try delegate.wrapped?.presenterRequestToNavigateBack(self)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    func updateETHUSDRate() {
        ethereumPriceService.refreshUSDPrice { response in
            // Return back on main thread
            DispatchQueue.main.async {
                switch response {
                case .failure(let error):
                    self.view.displayError(title: "Error", error: error)
                case .success(_):
                    self.view.setUSDFieldEnabled(true)
                    // To recalculate usd amount
                    self.setETHAmountString(self.ethAmountString)
                }
            }
        }
    }
    
    // MARK: ViewControllerProvider
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
