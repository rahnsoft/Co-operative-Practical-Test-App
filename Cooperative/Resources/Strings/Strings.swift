//
//  Strings.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation

// MARK: - Strings

/// Usage: Strings.commonBankGreetings.localized()

enum Strings: String {
    // MARK: Common

    case commonBankGreetings = "Common_Bank_Greetings"
    case commonBankUserGreetings = "Common_Bank_User_Greetings"
    case commonSave = "Common_Save"
    case commonOkay = "Common_Okay"
    case commonCancel = "Common_Cancel"
    case commonGotIt = "Common_GotIt"
    case commonContinue = "Common_Continue"
    case commonTryAgain = "Common_TryAgain"

    // MARK: Errors

    case commonGeneralError = "Common_GeneralError"
    case commonInternetError = "Common_InternetError"
    case invalidPhoneNumber = "Invalid_PhoneNumber"

    // MARK: Auth

    case loginTitle = "Login_Title"
    case loginUsername = "Login_Username"
    case loginPassword = "Login_Password"
    case loginUseCredentials = "Login_Use_Credentials"
    case logoutTitle = "Logout_Title"
    case loginSucess = "Login_Sucess"

    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }

    func localized(with arg: String) -> String {
        return String.localizedStringWithFormat(self.localized(), arg)
    }

    func localized(with arg: Int) -> String {
        return String.localizedStringWithFormat(self.localized(), arg)
    }

    func localized(with arg: Double) -> String {
        return String.localizedStringWithFormat(self.localized(), arg)
    }

    func localized(with args: [CVarArg]) -> String {
        return String(format: self.localized(), args)
    }

    func localized(with args: CVarArg...) -> String {
        return String(format: self.localized(), args)
    }
}
