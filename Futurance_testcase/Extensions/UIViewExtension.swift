//
//  UIViewExtension.swift
//  Futurance_testcase
//
//  Created by MacBook on 21.09.2022.
//


import Foundation
import UIKit

extension UIView {
    func keyboardSlide(){ //observer hangi uıview'deysek o olacak self sayesinde
        NotificationCenter.default.addObserver(self , selector: #selector(keyboardChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //burda yazdığım fonksiyon sayesinde kullanıcı klavyesi açıldığında diğer ekran elemanlarını kaydıracağız
    @objc func keyboardChange(_ notification : NSNotification ){
        //this time is about sliding of Keyboard
        let changeTime = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let initialKeyboardFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let lastKeyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let diffY = lastKeyboardFrame.origin.y - initialKeyboardFrame.origin.y
        
        UIView.animateKeyframes(withDuration: changeTime, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
            self.frame.origin.y += diffY
        }, completion: nil)
    }
    
    
}
