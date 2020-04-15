//
//  CurrencyConverter.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import BigInt

public struct CurrencyConverter {
    
    public static func convert(eth ethAmount: BigUInt, toUSDWith rate: Double, displayCurrencySymbol: Bool = true) -> String {
        let bigIntRate = BigUInt(integerLiteral: UInt64(rate * 100))
        
        let usdAmount = ethAmount.multiplied(by: bigIntRate).quotientAndRemainder(dividingBy: BigUInt(100)).quotient
        
        return (displayCurrencySymbol ? "$" : "") + usdAmount.string(units: .eth, decimals: 2, decimalSeparator: ".", options: .stripZeroes)
    }
    
    public static func convert(usd usdAmount: BigUInt, toETHWith ethRate: Double, displayCurrencySymbol: Bool = false) -> String {
        let bigIntRate = BigUInt(integerLiteral: UInt64(100 * ethRate))
        
        let ethAmount = usdAmount.quotientAndRemainder(dividingBy: bigIntRate).quotient.multiplied(by: 100)
        
        return ethAmount.string(units: .eth, decimals: 10, decimalSeparator: ".", options: .stripZeroes) + (displayCurrencySymbol ? " ETH" : "")
    }
    
}
