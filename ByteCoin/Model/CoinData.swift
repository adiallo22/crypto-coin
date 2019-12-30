//
//  CoinData.swift
//  ByteCoin
//
//  Created by Abdul Diallo on 12/28/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Codable {
    let last : Double
    let bid : Double
    let ask : Double
    let high : Double
    let low : Double
}
