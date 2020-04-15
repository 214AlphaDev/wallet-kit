//
//  ReceiveEtherPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit
import web3swift
import BigInt

public class ReceiveEtherPresenter: ReceiveEtherPresenterProtocol {
    
    public var delegate: WeakWrapper<ReceiveEtherPresenterDelegate> = WeakWrapper()
    public let view: ReceiveEtherViewProtocol
    private let wallet: Wallet
    
    public init(view: ReceiveEtherViewProtocol, wallet: Wallet) {
        self.view = view
        self.wallet = wallet
        
        view.presenter = WeakWrapper(self)
        view.displayAddress(String(describing: wallet.address))
    }
    
    public func copyAddressToClipboard() {
        UIPasteboard.general.string = String(describing: wallet.address)
    }
    
    public func close() {
        do {
            try delegate.wrapped?.presenterRequestToNavigateBack(self)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    // MARK: ViewControllerProvider
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
