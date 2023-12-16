//
//  CoopColors.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import UIKit

// MARK: - Colors

/// Usage: UIColor.cbThemeColor

enum CBColors: Int {
    case cbThemeColor = 1
    case cbTextColor = 2
    case inActiveButtonColor = 3

    func toColor() -> UIColor {
        switch self {
        case .cbThemeColor:
            return .cbThemeColor
        case .cbTextColor:
            return .cbTextColor
        case .inActiveButtonColor:
            return .inActiveButtonColor
        }
    }
}
