//
//  EthereumPriceService.swift
//  WalletKit
//
//  Created by Andrii Selivanov on 6/24/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public protocol EthereumPriceServiceProtocol {
    
    func currentUSDPrice() -> Double?
    func refreshUSDPrice(callback: @escaping (Response<Double>) -> Void)
    
}

public class EthereumPriceService: EthereumPriceServiceProtocol {
    
    private var currentUSDPriceCache: Double? = nil
    
    public init() {}
    
    public func currentUSDPrice() -> Double? {
        return currentUSDPriceCache
    }
    
    public func refreshUSDPrice(callback: @escaping (Response<Double>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd")!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(ResponseError.failedToGetETHPrice))
                return
            }
            
            guard
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let jsonDict = json as? [String: [String: Any]],
                let rate = jsonDict["ethereum"]?["usd"] as? Double
                else {
                    callback(.failure(ResponseError.failedToGetETHPrice))
                    return
            }
            
            self.currentUSDPriceCache = rate
            callback(.success(rate))
        }
        task.resume()
    }
    
    
}
