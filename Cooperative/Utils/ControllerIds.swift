//
//  ControllerIds.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation

// MARK: - ControllerIds
/// Usage: ControllerIds.homeVC.rawValue

enum ControllerIds: String {
    case loginViewVCIdentifier = "LoginViewController"
    case homeVCIdentifier = "HomeViewController"
}


// MARK: - ViewIds
/// Usage: ViewIds.homeView.rawValue

enum ViewIds: String {
    case cbSnackBarViewIdentifier = "CBSnackBarView"
    case cbButtonIdentifier = "CBButton"
}
