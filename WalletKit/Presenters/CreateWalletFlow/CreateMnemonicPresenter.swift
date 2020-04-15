//
//  CreateMnemonicPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import FlowKit

public class CreateMnemonicPresenter: CreateMnemonicPresenterProtocol {
    
    public var delegate: WeakWrapper<CreateMnemonicPresenterDelegate> = WeakWrapper()
    public let view: CreateMnemonicViewProtocol
    private let wallet: Wallet
    
    public init(view: CreateMnemonicViewProtocol, wallet: Wallet) {
        self.view = view
        self.wallet = wallet
        
        view.presenter = WeakWrapper(self)
        
        view.setMnemonicWords(wallet.mnemonic.words)
    }
    
    public func goToMnemonicConfirmation() {
        do {
            try delegate.wrapped?.presenter(self, requestNavigateToMnemonicConfirmationWith: wallet)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    // MARK: ViewControllerProvider
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
