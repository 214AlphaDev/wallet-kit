//
//  WalletLanding+MVP.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol WalletLandingPresenterDelegate: class {
    
    func presenterRequestNavigateToMnemonicCreate(_ presenter: WalletLandingPresenterProtocol) throws
    func presenterRequestNavigateToMnemonicRestore(_ presenter: WalletLandingPresenterProtocol) throws
    
}

public protocol WalletLandingPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<WalletLandingPresenterDelegate> { get set }
    var view: WalletLandingViewProtocol { get }
    
    func goToMnemonicCreate()
    func goToMnemonicResore()
    
}

public protocol WalletLandingViewProtocol: class, ViewControllerProvider, ErrorDisplayable {
    
    var presenter: WeakWrapper<WalletLandingPresenterProtocol> { get set }
    
}
