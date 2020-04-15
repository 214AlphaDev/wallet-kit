//
//  ReceiveEtherFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol ReceiveEtherFlowProtocol: Flow {}

public struct ReceiveEtherFlowFactory {
    
    public static func build(receiveEtherPresenter: ReceiveEtherPresenterProtocol) -> ReceiveEtherFlowProtocol {
        return ReceiveEtherFlow(receiveEtherPresenter: receiveEtherPresenter)
    }
    
}

class ReceiveEtherFlow: SingleScreenFlow, ReceiveEtherFlowProtocol, ReceiveEtherPresenterDelegate {
    
    init(receiveEtherPresenter: ReceiveEtherPresenterProtocol) {
        super.init(presenter: receiveEtherPresenter)
        
        receiveEtherPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: ReceiveEtherPresenterDelegate
    
    func presenterRequestToNavigateBack(_ presenter: ReceiveEtherPresenterProtocol) throws {
        try handle(action: CloseReceiveEtherFlowAction())
    }
    
}
