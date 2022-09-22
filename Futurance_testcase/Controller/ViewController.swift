//
//  ViewController.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
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
    
    @IBOutlet weak var miktarLabeli: UILabel!
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var coinMiktarTextField: UITextField!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alButton: UIButton!
    @IBOutlet weak var satButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        girisAyarları()
        tableView.delegate = self
        tableView.dataSource = self
        coinMiktarTextField.delegate = self
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        window.keyboardSlide()
        getData()
        
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func girisAyarları(){
        miktarLabeli.textColor = .darkGray
        totalTextField.isUserInteractionEnabled = false
        coinAlButton.backgroundColor = K.greenColor
        alButton.backgroundColor = K.greenColor
        satButton.backgroundColor = .gray
        alButton.layer.cornerRadius = alButton.frame.height/2
        satButton.layer.cornerRadius = satButton.frame.height/2
        coinAlButton.layer.cornerRadius = coinAlButton.frame.height/2
        alEtkili = true
    }
    
    func getData() {
        ApiService().loadPrice(baseSymbol: appSetting.baseSymbol) { result in
            if result != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func editChange(_ sender: UITextField){
        
        if sender.text == "" {
            totalTextField.text = "0"
        }
        if let myStr = Double(sender.text!) {
            let myquantity = myStr
            //print(myquantity * currentCoinPrice)
            var total = myquantity * currentCoinPrice
            total = (total * 10000) / 10000
            totalTextField.text = "\(total)"
        }
    }
    
    @IBAction func alButtonTapped(_ sender: UIButton) {
        coinAlButton.backgroundColor = K.greenColor
        satButton.backgroundColor = .gray
        alButton.backgroundColor = K.greenColor
        alEtkili = true
        coinAlButton.setTitle("\(currentCoinName) AL", for: UIControl.State.normal)
    }
    
    @IBAction func satButtonTapped(_ sender: UIButton) {
        coinAlButton.backgroundColor = K.redColor
        satButton.backgroundColor = K.redColor
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
                        /*
                        for (name) in myWallet.keys {
                            if currentCoinName == name {
                                myWallet[name]! += alinanCoinTutari
                                myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                            }else {
                                myWallet[currentCoinName] = alinanCoinTutari
                                myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                            }
                        }
                         */
                        //print("alıyoruz")
                        //print(alinanCoinTutari)
                        if myWallet.keys.contains(currentCoinName){
                            myWallet[currentCoinName] = myWallet[currentCoinName]! + Double(coinMiktarTextField.text!)!
                            myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                            myWallet["TRY"] = (myWallet["TRY"]! * 100000) / 100000
                        }else {
                            myWallet[currentCoinName] = Double(coinMiktarTextField.text!)
                            myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                            myWallet["TRY"] = (myWallet["TRY"]! * 100000) / 100000
                        }
                        // ALTTAKİ SATIR EĞER SON İŞLEM BAKİYE OLARAK GÖZÜKECEKSE AKTİF HALE GELECEK
                        //bakiyeLabel.text = "\(coinMiktarTextField.text!) \(currentCoinName), \(alinanCoinTutari) TRY  "
                    }
                }
            }
            // Aşağıdaki Satırlar eğer ki cüzdan toplam bakiyesi istenirse aktif hale gelecek
            
            bakiyeString = ""
            for (coin, price) in myWallet {
                newbakiyeString = "\(price) \(coin) "
                bakiyeString.append(contentsOf: newbakiyeString)
            }
            bakiyeLabel.text = bakiyeString
            print("Bakiye Stringi : \(bakiyeString)")
            print("*****")
        }
        else if alEtkili == false {
            if let alinanCoinTutari = Double(totalTextField.text!) {
                //myWallet[currentCoinName] = alinanCoinTutari
                /*
                 if myWallet.keys.contains(currentCoinName){
                     myWallet[currentCoinName] = myWallet[currentCoinName]! + Double(coinMiktarTextField.text!)!
                     myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                     myWallet["TRY"] = (myWallet["TRY"]! * 100000) / 100000
                 }else {
                     myWallet[currentCoinName] = Double(coinMiktarTextField.text!)
                     myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                     myWallet["TRY"] = (myWallet["TRY"]! * 100000) / 100000
                 }
                 */
                if myWallet.keys.contains(currentCoinName) {
                    myWallet[currentCoinName] = myWallet[currentCoinName]! - Double(coinMiktarTextField.text!)!
                    myWallet["TRY"] = myWallet["TRY"]! + alinanCoinTutari
                } else {
                    uyariVer(mesaj: "Bakiyenizde bu coin bulunmamaktadır. Satmak için önce coin'i satın almalısınız.")
                }
                
                //myWallet["TRY"] = myWallet["TRY"]! + alinanCoinTutari
            }
            //bakiyeLabel.text = "\(myWallet["TRY"]!) TRY"
            bakiyeString = ""
            for (coin, price) in myWallet {
                if price == 0 {
                    myWallet.removeValue(forKey: coin)
                }else {
                    newbakiyeString = "\(price) \(coin) "
                    bakiyeString.append(contentsOf: newbakiyeString)
                }
                /*
                newbakiyeString = "\(price) \(coin) "
                bakiyeString.append(contentsOf: newbakiyeString)
                 */
            }
            bakiyeLabel.text = bakiyeString
            print("Bakiye Stringi : \(bakiyeString)")
            print("*****")
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



