//
//  UIColor.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import UIKit

// MARK: - Colors

/// Usage: UIColor.themeColor

extension UIColor {
    static let cbThemeColor = UIColor(hex: "#7AC043")
    static let cbTextColor = UIColor(hex: "#F0F0F0")
    static let inActiveButtonColor = UIColor(hex: "#7a9f41").withAlphaComponent(0.8)
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }

    func toCBColors() -> CBColors {
        switch self {
        case .cbThemeColor:
            return .cbThemeColor
        case .cbTextColor:
            return .cbTextColor
        case .inActiveButtonColor:
            return .inActiveButtonColor
        default:
            return .cbThemeColor
        }
    }
}

// MARK: - Hex

/// Usage: UIColor(hex: "#FFFFFF", alpha: 0.5)

extension UIColor {
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
