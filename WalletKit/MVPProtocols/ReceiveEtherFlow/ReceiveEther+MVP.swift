//
//  ReceiveEther+MVP.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/21/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol ReceiveEtherPresenterDelegate: class {
    
    func presenterRequestToNavigateBack(_ presenter: ReceiveEtherPresenterProtocol) throws
    
}

public protocol ReceiveEtherPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<ReceiveEtherPresenterDelegate> { get set }
    var view: ReceiveEtherViewProtocol { get }
    
    func copyAddressToClipboard()
    func close()
    
}

public protocol ReceiveEtherViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<ReceiveEtherPresenterProtocol> { get set }
    
    func displayAddress(_ address: String)
    
}
