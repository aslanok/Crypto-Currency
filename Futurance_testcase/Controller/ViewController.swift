//
//  ViewController.swift
//  Futurance_testcase
//
//  Created by MacBook on 20.09.2022.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    var totalfor5decimal : Double = 0.0 //bu değişken didSelectRowAt fonksiyonu kullanılırken 24h high/low label'ını düzenlemek için kullanıldı.
    var alinanCoinMiktari : Double = 0.0
    var newbakiyeString : String = "" // bakiye stringine ekleme yapmak için bu değişkene yeni coinler atandı
    var total : String = "" //total coin fiyati için kullandık
    var bakiyeString : String = ""
    var myWallet : [String : Double] = ["TRY" : 2000.0] //her coin miktarını tutmak için dict yapısı kullanıldı
    var currentCoinPrice : Double = 1 //tableviewden tıklanan/seçilen coin fiyatını tutuyor
    var currentCoinName : String = "" //tableviewden tıklanan/seçilen coin adını tutuyor
    var alEtkili = true //al sat butonundan hangisi aktif onu belirlemek için kullanıldı
    
    
    @IBOutlet weak var bakiyeLabel: UILabel!
    @IBOutlet weak var coinAlButton: UIButton! //ekranın en altında bulunan coin alım satım işlemlerini yaptığımız button
    @IBOutlet var window: UIView!
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
        window.keyboardSlide()
        getData()
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func girisAyarları(){
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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
        // kullanıcı istediği coini burda mainCoin yapabilir. Yazım hatası olmasın diye Constants dosyasında mainSymbol isimli bir değişken yarattık. Kullanıcı istediği coini ordan da değiştirebilir.
        WebService().loadPrice(mainCoin: K.mainSymbol) { result in
            if result != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //anlık coin miktarı değişimlerinde hesaplamalar yapılıp total kısmında gösteriliyor
    @IBAction func editChange(_ sender: UITextField){
        
        if sender.text == "" {
            totalTextField.text = "0"
        }
        if let myStr = Double(sender.text!) {
            let myquantity = myStr
            //print(myquantity * currentCoinPrice)
            var total = myquantity * currentCoinPrice
            total = (round(total * 10000)/10000)
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
    
    //Coin alma satma işlemleri için kullanılan ekranın en aşağısındaki butona tıklanınca tetiklenen işlemler
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
                        if myWallet.keys.contains(currentCoinName){
                            myWallet[currentCoinName] = myWallet[currentCoinName]! + Double(coinMiktarTextField.text!)!
                            myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                            myWallet["TRY"] = (round(10000*myWallet["TRY"]!)/10000)
                        }else {
                            myWallet[currentCoinName] = Double(coinMiktarTextField.text!)
                            myWallet["TRY"] = myWallet["TRY"]! - alinanCoinTutari
                            myWallet["TRY"] = (round(10000 * myWallet["TRY"]!)/10000)
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
            if let alinanMiktar = Double(coinMiktarTextField.text!) {
                alinanCoinMiktari = alinanMiktar
            }
            if let alinanCoinTutari = Double(totalTextField.text!) {
                if myWallet.keys.contains(currentCoinName) {
                    if myWallet[currentCoinName]! < alinanCoinMiktari {
                        uyariVer(mesaj: "Satmaya çalıştığınız coin sayısı bakiyenizde bulunmuyor.Daha az coin satmayı deneyiniz")
                    }else {
                        myWallet[currentCoinName] = myWallet[currentCoinName]! - Double(coinMiktarTextField.text!)!
                        myWallet["TRY"] = myWallet["TRY"]! + alinanCoinTutari
                        myWallet["TRY"] = (round(10000 * myWallet["TRY"]!)/10000)
                    }
                } else {
                    uyariVer(mesaj: "Bakiyenizde bu coin bulunmamaktadır. Satmak için önce coin'i satın almalısınız.")
                }
            }
            bakiyeString = ""
            for (coin, price) in myWallet {
                if price == 0 {
                    myWallet.removeValue(forKey: coin)
                }else {
                    newbakiyeString = "\(price) \(coin) "
                    bakiyeString.append(contentsOf: newbakiyeString)
                }
            }
            bakiyeLabel.text = bakiyeString
        }
    }
    
}



