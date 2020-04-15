//
//  EnterMnemonicPresenter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/22/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public class EnterMnemonicPresenter: EnterMnemonicPresenterProtocol {
    
    public var delegate: WeakWrapper<EnterMnemonicPresenterDelegate> = WeakWrapper()
    public var view: EnterMnemonicViewProtocol
    private var mnemonicWords = [String](repeating: "", count: Constants.mnemonicLength)
    
    public init(view: EnterMnemonicViewProtocol) {
        self.view = view
        view.presenter = WeakWrapper(self)
    }
    
    
    /// Method to override on subclasses to proceed mnemonic and return a wallet
    ///
    /// - Parameter mnemonic: Mnemonic to handle
    /// - Returns: Response with wallet object or error
    open func proceedMnemonic(_ mnemonic: Mnemonic) -> Response<Wallet> {
        return .failure(GeneralError.unimplemented)
    }
    
    public func submit() {
        do {
            let mnemonic = try Mnemonic(words: mnemonicWords)
            
            for word in mnemonic.words {
                if case .invalid(let error) = validateMnemonicWord(word, partialAllowed: false) {
                    throw error
                }
            }
            
            let response = proceedMnemonic(mnemonic)
            switch response {
            case .failure(let error):
                throw error
            case .success(let wallet):
                self.view.setLoadingIndicatorVisible(false)
                try self.delegate.wrapped?.presenter(self, requestNavigateToWalletWith: wallet)
            }
        } catch {
            view.setLoadingIndicatorVisible(false)
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func setMnemonicWord(_ word: String, at index: Int) {
        if mnemonicWords.indices.contains(index) {
            mnemonicWords[index] = word
        }
    }
    
    public func cleanUp() {
        mnemonicWords = [String](repeating: "", count: Constants.mnemonicLength)
        view.cleanUp()
    }
    
    // MARK: Validation
    
    public func validateMnemonicWord(_ word: String, partialAllowed: Bool) -> ValidationResult {
        if !partialAllowed && word.isEmpty {
            return .invalid(ValidationError.invalidEmptyMnemonicWord)
        }
        
        return (word.range(of: "\\P{Latin}", options: .regularExpression) == nil) ? .valid : .invalid(ValidationError.invalidCharacterInMnemonicWord)
    }
    
    // MARK: ViewControllerProvider
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
