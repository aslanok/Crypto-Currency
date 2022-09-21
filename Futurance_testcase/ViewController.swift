//
//  ViewController.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var newbakiyeString : String = ""
    @IBOutlet weak var bakiyeLabel: UILabel!
    @IBOutlet weak var coinAlButton: UIButton!
    @IBOutlet var window: UIView!
    var total : String = ""
    var bakiyeString : String = ""
    var myWallet : [String : Double] = ["TRY" : 2000.0]
    var currentCoinPrice : Double = 1
    var currentCoinName : String = ""
    var alEtkili = true
    
    var greenColor = UIColor(red: 77/255.0, green: 199/255.0, blue: 152/255.0, alpha: 1)
    var redColor = UIColor(red: 241/255.0, green: 105/255.0, blue: 99/255.0, alpha: 1)
    

    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var coinMiktarTextField: UITextField!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alButton: UIButton!
    @IBOutlet weak var satButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        //view.addGestureRecognizer(gestureRecognizer)
        girisAyarları()
        tableView.delegate = self
        tableView.dataSource = self
        coinMiktarTextField.delegate = self
        
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view.
        window.keyboardSlide()
        getData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
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
    
    /*
    @IBAction func actionTriggered(_ sender: UITextField) {
        if let myStr = Double(textField.text!) {
            let myquantity = myStr
            print(myquantity * currentCoinPrice)
            let total = String(myquantity * currentCoinPrice)
            totalTextField.text = total
        
    }
     */
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func girisAyarları(){
        totalTextField.isUserInteractionEnabled = false
        coinAlButton.backgroundColor = greenColor
        alButton.backgroundColor = greenColor
        satButton.backgroundColor = .gray
        alButton.layer.cornerRadius = alButton.frame.height/2
        satButton.layer.cornerRadius = satButton.frame.height/2
        coinAlButton.layer.cornerRadius = coinAlButton.frame.height/2
        alEtkili = true
    }
    
    func getData() {
        ApiService().loadTickerPrice(baseSymbol: appSetting.baseSymbol) { result in
            if result != nil {
                DispatchQueue.main.async {
//                    print("get datadaki result : \(result?[0].name)")
                    //print(result as Any)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    /*
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let myStr = Double(textField.text!) {
            let myquantity = myStr
            //print(myquantity * currentCoinPrice)
            let total = String(myquantity * currentCoinPrice)
            totalTextField.text = total
        }
    }
*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }
    
    
    @IBAction func editChange(_ sender: UITextField){
        
        if sender.text == "" {
            totalTextField.text = "0"
        }
        
        if let myStr = Double(sender.text!) {
            let myquantity = myStr
            //print(myquantity * currentCoinPrice)
            let total = String(myquantity * currentCoinPrice)
            totalTextField.text = total
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.setup(with: currencyData[indexPath.row])
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        return cell
    }
    
    
    //cell'e basınca çalışıyor
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myData = currencyData[indexPath.row]
        highLabel.text = myData.highPrice
        lowLabel.text = myData.lowPrice
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
        
    }
    
    
    @IBAction func alButtonTapped(_ sender: UIButton) {
        coinAlButton.backgroundColor = greenColor
        satButton.backgroundColor = .gray
        alButton.backgroundColor = greenColor
        alEtkili = true
        coinAlButton.setTitle("\(currentCoinName) AL", for: UIControl.State.normal)
    }
    
    @IBAction func satButtonTapped(_ sender: UIButton) {
        coinAlButton.backgroundColor = redColor
        satButton.backgroundColor = redColor
        alButton.backgroundColor = .gray
        alEtkili = false
        coinAlButton.setTitle("\(currentCoinName) SAT", for: UIControl.State.normal)
    }
    
    
    
    @IBAction func coinAlButtonTapped(_ sender: UIButton) {
        if alEtkili == true {
            if let alinanCoinTutari = Double(totalTextField.text!) {
                if myWallet["TRY"]! < alinanCoinTutari {
                    print("coin alınamaz")
                    uyariVer(mesaj: "Yetersiz Bakiye")
                }
                else {
                    if currentCoinName == "" {
                        uyariVer(mesaj: "Coin Seçmediniz")
                    }else {
                        print("alıyoruz")
                        //print(alinanCoinTutari)
                        myWallet[currentCoinName] = alinanCoinTutari
                        myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                        bakiyeLabel.text = "\(coinMiktarTextField.text!) \(currentCoinName), \(alinanCoinTutari) TRY  "
                    }
                }
            }
            //print(myWallet["TRY"]!)
            /*
            for (coin, price) in myWallet {
                newbakiyeString = "\(price) \(coin) "
                bakiyeString.append(contentsOf: newbakiyeString)
            }
            bakiyeLabel.text = bakiyeString
            print(bakiyeString)
            print("*****")
             */
        }
        else if alEtkili == false {
            if let alinanCoinTutari = Double(totalTextField.text!) {
                myWallet[currentCoinName] = alinanCoinTutari
                myWallet["TRY"] = myWallet["TRY"]! + alinanCoinTutari
            }
            bakiyeLabel.text = "\(myWallet["TRY"]!) TRY"
        }
    }
    
    
    func uyariVer(mesaj : String) {
            let uyariMesaji : UIAlertController = UIAlertController(title: "Uyarı Mesajı!", message: mesaj, preferredStyle: UIAlertController.Style.alert)
            let okButton : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                print("ok butonuna tıklandı")
            }
            
            uyariMesaji.addAction(okButton)
            // burda kullaniciya uyari mesajı sunduk, animasyonlu mu olsun evet, tamamlanınca bir şey olsun mu hayır olmasın
            self.present(uyariMesaji, animated: true, completion: nil)
        }
}


extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
