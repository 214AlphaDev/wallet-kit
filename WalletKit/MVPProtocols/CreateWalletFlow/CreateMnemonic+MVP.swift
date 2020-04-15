//
//  CreateMnemonic+MVP.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/21/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol CreateMnemonicPresenterDelegate: class {
    
    func presenter(_ presenter: CreateMnemonicPresenterProtocol, requestNavigateToMnemonicConfirmationWith wallet: Wallet) throws
    
}

public protocol CreateMnemonicPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<CreateMnemonicPresenterDelegate> { get set }
    var view: CreateMnemonicViewProtocol { get }
    
    func goToMnemonicConfirmation()
    
}

public protocol CreateMnemonicViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<CreateMnemonicPresenterProtocol> { get set }
    
    func setMnemonicWords(_ words: [String])
    
}
