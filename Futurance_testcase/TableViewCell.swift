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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(with currency : CurrencyModel) {
        coinNameLabel.text = currency.name
        coinPriceLabel.text = currency.price
    }

}
