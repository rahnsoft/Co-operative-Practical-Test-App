//
//  UITextField+CB.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 16/12/2023.
//

import Foundation
import UIKit
// Mark - UITextField
/// Usage: textField.enablePasswordToggle()

extension UITextField {
fileprivate func setPasswordToggleImage(_ button: UIButton) {
    if(isSecureTextEntry){
        button.setImage(UIImage(named: "password_visible_icon"), for: .normal)
    }else{
        button.setImage(UIImage(named: "password_hide_icon"), for: .normal)

    }
}

/// Enables password toggle on the right side of the textfield
func enablePasswordToggle(){
    let button = UIButton(type: .custom)
    setPasswordToggleImage(button)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(30), height: CGFloat(30))
    button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    self.rightView = button
    self.rightViewMode = .always
}
    
@objc func togglePasswordView(_ sender: Any) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    setPasswordToggleImage(sender as! UIButton)
}
}
