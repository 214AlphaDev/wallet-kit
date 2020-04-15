//
//  SendEtherFlow.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol SendEtherFlowProtocol: Flow {}

public struct SendEtherFlowFactory {
    
    public static func build(sendEtherPresenter: SendEtherPresenterProtocol) -> SendEtherFlowProtocol {
        return SendEtherFlow(sendEtherPresenter: sendEtherPresenter)
    }
    
}

class SendEtherFlow: SingleScreenFlow, SendEtherFlowProtocol, SendEtherPresenterDelegate {
    
    init(sendEtherPresenter: SendEtherPresenterProtocol) {
        super.init(presenter: sendEtherPresenter)
        
        sendEtherPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: SendEtherPresenterDelegate
    
    func presenterRequestToNavigateBack(_ presenter: SendEtherPresenterProtocol) throws {
        try handle(action: CloseSendEtherFlowAction())
    }
    
}
