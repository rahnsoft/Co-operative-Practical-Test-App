//
//  NSLayoutConstraint+CB.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import UIKit

// MARK: - Keyboard
/// This extension is used to update the constraint of the view when the keyboard appears or disappears

extension NSLayoutConstraint {
    func updateConstantWithAnimation(_ constant: CGFloat, _ view: UIView) {
        self.constant = constant
        UIView.animate(withDuration: 0.3) {
            view.layoutIfNeeded()
        }
    }
}
