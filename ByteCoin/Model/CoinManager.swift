//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Abdul Diallo on 12/28/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func failedWithError(error: Error)
    func updatedPrice(price: CoinGroup, currency: String)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["USD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","AUD","ZAR"]
    
    func returnPrice(_ currency : String) {
        let newURL = "\(baseURL)\(currency)"
        if let url = URL(string: newURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.failedWithError(error: error!)
                    return
                }
                if let existData = data {
                if let price = self.parseJSON(existData) {
                    //let priceString = String(format: "%.2f", price)
                    self.delegate?.updatedPrice(price: price, currency: currency)
                }
            }
        }
        task.resume()
        }
        
    }
    

    func parseJSON(_ data: Data) -> CoinGroup? {
            let decoder = JSONDecoder()
            do {
                let dataDecoded = try decoder.decode(CoinData.self, from: data)
                let lastPrice = dataDecoded.last
                let last = String(format: "%.2f", lastPrice)
                let bidPrice = dataDecoded.bid
                let bid = String(format: "%.2f", bidPrice)
                let askPrice = dataDecoded.ask
                let ask = String(format: "%.2f", askPrice)
                let highPrice = dataDecoded.high
                let high = String(format: "%.2f", highPrice)
                let lowPrice = dataDecoded.low
                let low = String(format: "%.2f", lowPrice)
                let coinGroup = CoinGroup(last: last, ask: ask, bid: bid, high: high, low: low)
                return coinGroup
            } catch {
                delegate?.failedWithError(error: error)
                return nil
            }
        }
        
}
