//
//  EnterMnemonic+MVP.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/21/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol EnterMnemonicPresenterDelegate: class {
    
    func presenter(_ presenter: EnterMnemonicPresenterProtocol, requestNavigateToWalletWith wallet: Wallet) throws
    
}

public protocol EnterMnemonicPresenterProtocol: Presenter, Cleanable {
    
    var delegate: WeakWrapper<EnterMnemonicPresenterDelegate> { get set }
    var view: EnterMnemonicViewProtocol { get }
    
    func setMnemonicWord(_ word: String, at index: Int)
    func submit()
    
    /// Validates the correctness of mnemonic word
    ///
    /// - Parameters:
    ///   - word: Word to validate
    ///   - partialAllowed: Flag if validation should allow partial word, which happens in a process of input.
    /// - Returns: Validation result.
    func validateMnemonicWord(_ word: String, partialAllowed: Bool) -> ValidationResult
    
}

public protocol ConfirmMnemonicPresenterProtocol: EnterMnemonicPresenterProtocol {}

public protocol RestoreMnemonicPresenterProtocol: EnterMnemonicPresenterProtocol {}

public enum MnemonicEnterObjective {
    case restore
    case confirm
}

public protocol EnterMnemonicViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable, Cleanable {
    
    var presenter: WeakWrapper<EnterMnemonicPresenterProtocol> { get set }
    
    func setMnemonicEnterObjective(_ objective: MnemonicEnterObjective)
    
}
