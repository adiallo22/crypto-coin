//
//  CoinGroup.swift
//  ByteCoin
//
//  Created by Abdul Diallo on 12/28/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


class CoinGroup {
    let last : String
    let bid : String
    let ask : String
    let high : String
    let low : String
    init(last: String, ask: String, bid: String, high: String, low: String) {
        self.last = last
        self.ask = ask
        self.bid = bid
        self.high = high
        self.low = low
    }
}
