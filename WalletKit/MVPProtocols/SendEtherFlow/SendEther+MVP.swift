//
//  SendEther+MVP.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/21/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit
import BigInt

public protocol SendEtherPresenterDelegate: class {
    
    func presenterRequestToNavigateBack(_ presenter: SendEtherPresenterProtocol) throws
    
}

public enum TransactionSpeed {
    case high
    case medium
    case low
    
    func toWei() -> BigUInt {
        switch self {
        case .high:
            return BigUInt("60", units: .gWei)!
        case .low:
            return BigUInt("20", units: .gWei)!
        case .medium:
            return BigUInt("40", units: .gWei)!
        }
    }
    
}

public enum SendEtherValidationField {
    case address(String)
    case amountString(String)
}

public protocol SendEtherPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<SendEtherPresenterDelegate> { get set }
    var view: SendEtherViewProtocol { get }
    
    func setETHAmountString(_ amountString: String)
    func setUSDAmountString(_ amountString: String)
    func setAddress(_ address: String)
    func setTransactionSpeed(_ speed: TransactionSpeed)
    func validate(field: SendEtherValidationField) -> ValidationResult
    func send()
    func close()
    
}

public protocol SendEtherViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<SendEtherPresenterProtocol> { get set }
    
    func setUSDFieldEnabled(_ enabled: Bool)
    func displayETHAmountString(_ amountString: String)
    func displayUSDAmountString(_ amountString: String)
    
}
