//
//  ViewController.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var currentCoinPrice : Double = 1
    
    var greenColor = UIColor(red: 77/255.0, green: 199/255.0, blue: 152/255.0, alpha: 1)
    var redColor = UIColor(red: 241/255.0, green: 105/255.0, blue: 99/255.0, alpha: 1)
    

    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var coinMiktarTextField: UITextField!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var altButton: UIButton!
    @IBOutlet weak var alButton: UIButton!
    @IBOutlet weak var satButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        //view.addGestureRecognizer(gestureRecognizer)
        girisAyarları()
        altButton.backgroundColor = greenColor
        tableView.delegate = self
        tableView.dataSource = self
        coinMiktarTextField.delegate = self
        // Do any additional setup after loading the view.
        getData()
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func girisAyarları(){
        alButton.backgroundColor = greenColor
        satButton.backgroundColor = .gray
        alButton.layer.cornerRadius = alButton.frame.height/2
        satButton.layer.cornerRadius = satButton.frame.height/2
        altButton.layer.cornerRadius = altButton.frame.height/2
    }
    
    func getData() {
        ApiService().loadTickerPrice(baseSymbol: appSetting.baseSymbol) { result in
            if result != nil {
                DispatchQueue.main.async {
//                    print("get datadaki result : \(result?[0].name)")
                    print(result as Any)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let myStr = Double(textField.text!) {
            let myquantity = myStr
            print(myquantity * currentCoinPrice)
            let total = String(myquantity * currentCoinPrice)
            totalTextField.text = total
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.setup(with: currencyData[indexPath.row])
        return cell
    }
    
    //cell'e basınca çalışıyor
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myData = currencyData[indexPath.row]
        highLabel.text = myData.highPrice
        lowLabel.text = myData.lowPrice
        if let cost = Double(myData.price) {
            currentCoinPrice = cost
            print(currentCoinPrice)
        }
    }
    
    
    @IBAction func alButtonTapped(_ sender: UIButton) {
        altButton.backgroundColor = greenColor
        satButton.backgroundColor = .gray
        alButton.backgroundColor = greenColor
    }
    
    
    @IBAction func satButtonTapped(_ sender: UIButton) {
        altButton.backgroundColor = redColor
        satButton.backgroundColor = redColor
        alButton.backgroundColor = .gray
    }
    
    
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
