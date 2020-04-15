//
//  Actions.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 5/26/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import FlowKit

class DisplayCreateMnemonicFlowAction: Action {}
class CloseCreateMnemonicFlowAction: PopAction<CreateMnemonicFlowProtocol> {}

class DisplayRestoreMnemonicFlowAction: Action {}
class CloseRestoreMnemonicFlowAction: PopAction<RestoreMnemonicFlowProtocol> {}

class DisplayConfirmMnemonicFlowAction: Action {
    let wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
class CloseConfirmMnemonicFlowAction: PopAction<ConfirmMnemonicFlowProtocol> {}

class DisplayWalletFlowAction: Action {
    let wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
