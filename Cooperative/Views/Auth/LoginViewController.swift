//
//  ViewController.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 01/12/2023.
//

import IQKeyboardManagerSwift
import RxSwift
import SkyFloatingLabelTextField
import UIKit

class LoginViewController: KeyboardViewController {
    @IBOutlet var loginButton: CBButton!
    @IBOutlet var loginUseCredentialsLbl: UILabel!
    @IBOutlet var loginBankGreetingsLbl: UILabel!
    @IBOutlet var usernameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextFieldWithIcon!

    private var viewModel: LoginViewModel

    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ControllerIds.loginViewVCIdentifier.rawValue, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.removeInfo()
        configureView()
        configureTextFields()
        configureObservables()
    }

    func configureView() {
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        loginButton.status = .enabled
        loginButton.text = Strings.loginTitle.localized().uppercased()
        loginButton.configureCornerRadius(5)
    }

    func configureTextFields() {
        usernameTextField.becomeFirstResponder()
        usernameTextField.title = Strings.loginUsername.localized()
        usernameTextField.placeholder = Strings.loginUsername.localized()
        usernameTextField.placeholderColor = .cbTextColor
        usernameTextField.titleFont = .CBFont.regular.font(12)
        usernameTextField.placeholderFont = .CBFont.regular.font(16)
        usernameTextField.placeholderColor = .cbTextColor
        usernameTextField.font = .CBFont.regular.font(16)
        usernameTextField.textColor = .cbTextColor
        usernameTextField.lineColor = .cbTextColor
        usernameTextField.tintColor = .cbTextColor
        usernameTextField.titleColor = .cbTextColor
        usernameTextField.selectedTitleColor = .cbThemeColor
        usernameTextField.selectedLineColor = .cbThemeColor
        usernameTextField.iconType = .image
        usernameTextField.iconImage = UIImage(systemName: "person")?.withRenderingMode(.alwaysTemplate)
        usernameTextField.iconColor = UIColor.cbTextColor
        usernameTextField.selectedIconColor = UIColor.cbThemeColor
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.layer.borderColor = UIColor.cbTextColor.cgColor
        usernameTextField.layer.borderWidth = 0.4
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.clipsToBounds = true

        passwordTextField.title = Strings.loginUsername.localized()
        passwordTextField.placeholder = Strings.loginPassword.localized()
        passwordTextField.titleFont = .CBFont.regular.font(12)
        passwordTextField.placeholderFont = .CBFont.regular.font(16)
        passwordTextField.placeholderFont = .CBFont.regular.font(16)
        passwordTextField.placeholderColor = .cbTextColor
        passwordTextField.font = .CBFont.regular.font(16)
        passwordTextField.textColor = .cbTextColor
        passwordTextField.lineColor = .cbTextColor
        passwordTextField.tintColor = .cbTextColor
        passwordTextField.titleColor = .cbTextColor
        passwordTextField.selectedTitleColor = .cbThemeColor
        passwordTextField.selectedLineColor = .cbThemeColor
        passwordTextField.selectedIconColor = UIColor.cbThemeColor
        passwordTextField.iconType = .image
        passwordTextField.iconImage = UIImage(systemName: "lock")?.withRenderingMode(.alwaysTemplate)
        passwordTextField.iconColor = UIColor.cbTextColor
        passwordTextField.iconMarginLeft = 8
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor.cbTextColor.cgColor
        passwordTextField.layer.borderWidth = 0.4
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.clipsToBounds = true
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablePasswordToggle()
    }

    private func configureObservables() {
        viewModel.loadingRelay.subscribe(onNext: { [weak self] loading in
            guard let self = self else { return }
            self.loginButton.status = loading ? .loading : .enabled
        }).disposed(by: disposeBag)
        
        viewModel.errorRelay.subscribe(onNext: { [weak self] error in
            guard let self = self else { return }
            self.showSnackError(error)
            self.loginButton.status = .enabled
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                guard let self = self else { return }
                self.passwordTextField.becomeFirstResponder()
            }
        }).disposed(by: disposeBag)

        viewModel.successRelay.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let model = CBSnackBarView.ViewModel(messageText: String(format: Strings.loginSucess.localized()),
                                                 buttonText: Strings.commonOkay.localized().uppercased())

            self.showSnackBar(model, 4)
            self.loginButton.status = .disabled
        }).disposed(by: disposeBag)

        loginButton.button.rx.tap.asDriver().drive(onNext: { [unowned self] in
            loginButton.status = .loading
            viewModel.setupLoginData(usernameTextField.text ?? "", passwordTextField.text ?? "")
        }).disposed(by: disposeBag)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            usernameTextField.layer.borderColor = UIColor.cbThemeColor.cgColor
            usernameTextField.rightView?.tintColor = .cbThemeColor
        } else {
            passwordTextField.layer.borderColor = UIColor.cbThemeColor.cgColor
            passwordTextField.rightView?.tintColor = .cbThemeColor
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            usernameTextField.layer.borderColor = UIColor.cbTextColor.cgColor
            usernameTextField.rightView?.tintColor = .cbTextColor
        } else {
            passwordTextField.layer.borderColor = UIColor.cbTextColor.cgColor
            passwordTextField.rightView?.tintColor = .cbTextColor
        }
    }
}
