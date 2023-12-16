//
//  Utils+AppDelegate.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import UIKit
// MARK: - AppDelegate
/// Usage: appDelegate

var appDelegate: AppDelegate {
    get {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
