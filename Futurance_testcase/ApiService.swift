//
//  ApiService.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
// Okan

import Foundation

class ApiService {
    
    func loadTickerPrice(baseSymbol: String, completion: @escaping ([CurrencyModel]?) -> ()) {
        currencyData.removeAll()
        let url = URL(string: "https://www.binance.com/api/v3/ticker/24hr")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { print("nil"); completion(nil); return}
            do {
                let btcArr =  try JSONDecoder().decode([Response].self, from: data)
                //print("Aldığımız veri : \(btcArr)")
                for item in btcArr.filter({ $0.symbol.suffix(baseSymbol.count) == baseSymbol }) {
                    print(item)                        //print(item)
                    DispatchQueue.main.async {
                        //let coinName = item.symbol
                        let price = "\(item.lastPrice)"
                        let firstName = item.symbol.prefix(item.symbol.count - baseSymbol.count)
                        let combineName = "\(firstName)/\(baseSymbol)"
                        let lowerPrice = item.lowPrice
                        let higherPrice = item.highPrice
                        let curr = CurrencyModel(name: String(combineName), price: price, lowPrice: lowerPrice, highPrice: higherPrice )
                        currencyData.append(curr)
                    }
                }
                completion(currencyData)
                print(currencyData)
            } catch let error as NSError {
                completion(nil)
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
    }
}
