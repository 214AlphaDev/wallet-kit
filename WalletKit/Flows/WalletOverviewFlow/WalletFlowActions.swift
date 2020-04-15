//
//  Actions.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 5/26/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import FlowKit

class DisplaySendEtherFlowAction: Action {
    let wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
class CloseSendEtherFlowAction: Action {}

class DisplayReceiveEtherFlowAction: Action {
    let wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
class CloseReceiveEtherFlowAction: Action {}
