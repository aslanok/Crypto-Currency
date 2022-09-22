//
//  Cell.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(with currency : CurrencyModel) {
        
        if let coinChangingPrice = Double(currency.coinPriceChange) {
            if coinChangingPrice < 0 {
                coinPriceLabel.textColor = K.redColor
                priceChangeLabel.textColor = K.redColor
                priceChangeLabel.text =  "% \(currency.coinPriceChange)"
            } else {
                priceChangeLabel.text =  "% +\(currency.coinPriceChange)"
                coinPriceLabel.textColor = K.greenColor
                priceChangeLabel.textColor = K.greenColor
            }
        }
        
        coinNameLabel.text = currency.name
        
        coinPriceLabel.text = "\(currency.price) TRY"
    }

}
