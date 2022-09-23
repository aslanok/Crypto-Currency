//
//  CoinData.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import Foundation

//Api dönütlerini burda ele aldık
struct Response: Codable {
    let symbol : String
    let lastPrice: String
    let highPrice : String
    let lowPrice : String
    let priceChangePercent : String
}

