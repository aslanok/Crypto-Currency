//
//  ApiService.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
// Okan

import Foundation

//gerekli api işlemleri burda yapılıyor
struct WebService {
    
    func loadPrice(mainCoin: String, completion: @escaping ([CurrencyModel]?) -> ()) {
        currencyData.removeAll()
        let url = URL(string: K.binanceURL)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { print("nil"); completion(nil); return}
            do {
                let btcArr =  try JSONDecoder().decode([Response].self, from: data)
                //print("Aldığımız veri : \(btcArr)")
                for item in btcArr.filter({ $0.symbol.suffix(mainCoin.count) == mainCoin }) {
                    //print(item)
                    DispatchQueue.main.async {
                        let coinPriceChange = item.priceChangePercent
                        let price = item.lastPrice
                        let firstName = item.symbol.prefix(item.symbol.count - mainCoin.count)
                        let combineName = "\(firstName)/\(mainCoin)"
                        let lowerPrice = item.lowPrice
                        let higherPrice = item.highPrice
                        let curr = CurrencyModel(name: String(combineName), price: price, lowPrice: lowerPrice, highPrice: higherPrice, soloCoinName: String(firstName) , coinPriceChange: coinPriceChange)
                        currencyData.append(curr)
                    }
                }
                completion(currencyData)
                //print(currencyData)
            } catch let error as NSError {
                completion(nil)
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
    }
}
