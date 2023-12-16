//
//  UIFont+CB.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import UIKit
// Mark - UIFont
/// Usage: CBFont.regular

extension UIFont {
    enum CBFont: String {
        case regular = "NunitoSans10pt-Regular"
        case semiBold = "NunitoSans10pt-SemiBold"
        case bold = "NunitoSans10pt-Bold"

        func font(_ size: CGFloat) -> UIFont {
            guard let font = UIFont(name: rawValue, size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
    }
}
