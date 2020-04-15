//
//  WalletLandingPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public class WalletLandingPresenter: WalletLandingPresenterProtocol {
    
    public var delegate: WeakWrapper<WalletLandingPresenterDelegate> = WeakWrapper()
    public let view: WalletLandingViewProtocol
    
    public init(view: WalletLandingViewProtocol) {
        self.view = view
        view.presenter = WeakWrapper(self)
    }
    
    public func goToMnemonicCreate() {
        do {
            try delegate.wrapped?.presenterRequestNavigateToMnemonicCreate(self)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func goToMnemonicResore() {
        do {
            try delegate.wrapped?.presenterRequestNavigateToMnemonicRestore(self)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
