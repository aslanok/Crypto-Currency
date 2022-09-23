//
//  TableViewExtension.swift
//  Futurance_testcase
//
//  Created by MacBook on 22.09.2022.
//

import Foundation
import UIKit

extension ViewController {
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
