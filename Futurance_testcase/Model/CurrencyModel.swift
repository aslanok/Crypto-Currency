//
//  CoinModel.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import Foundation

struct CurrencyModel {
    var name : String
    var price : String
    var lowPrice : String
    var highPrice : String
    var soloCoinName : String
    var coinPriceChange : String
}

//apiden dönen arraydeki elemanları kaydetmek için bi array oluşturduk ve bu arrayi de apiService içinde kullandık
var currencyData : [CurrencyModel] = []
