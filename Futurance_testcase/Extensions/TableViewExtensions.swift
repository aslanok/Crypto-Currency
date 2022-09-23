//
//  TableViewExtensions.swift
//  Futurance_testcase
//
//  Created by MacBook on 22.09.2022.
//

import Foundation
import UIKit

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let myStr = Double(textField.text!) {
            let myquantity = myStr
            //print(myquantity * currentCoinPrice)
            total = String(myquantity * currentCoinPrice)
            totalTextField.text = total
        }
        closeKeyboard()
        return true
    }
    
    //cell'e basınca çalışıyor
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myData = currencyData[indexPath.row]
        if var newCoinhighFiyat = Double(myData.highPrice) {
            newCoinhighFiyat = (newCoinhighFiyat * 100000) / 100000
            highLabel.text = "\(newCoinhighFiyat)"
        }
        if var newCoinlowFiyat = Double(myData.lowPrice) {
            newCoinlowFiyat = (newCoinlowFiyat * 100000) / 100000
            lowLabel.text = "\(newCoinlowFiyat)"
        }
        
        
        //highLabel.text = myData.highPrice
        //lowLabel.text = myData.lowPrice
        if let cost = Double(myData.price) {
            currentCoinPrice = cost
            //print(currentCoinPrice)
        }
        currentCoinName = myData.soloCoinName
        if alEtkili == true {
            coinAlButton.setTitle("\(currentCoinName) AL", for: UIControl.State.normal)
        } else {
            coinAlButton.setTitle("\(currentCoinName) SAT", for: UIControl.State.normal)
        }
        //
        if let coinquantity = Double(coinMiktarTextField.text!) {
            total = String(coinquantity * currentCoinPrice)
            totalTextField.text = total
        }
        
        miktarLabeli.text = "\(currentCoinName) Miktari"
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.setup(with: currencyData[indexPath.row])
        cell.cellView.layer.cornerRadius = 20
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
