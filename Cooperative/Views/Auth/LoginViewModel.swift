//
//  LoginViewModel.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDomain
import RxRelay
import RxSwift

class LoginViewModel: BaseViewModel {
    private var coordinator: LoginCoordinator?
    private let removeUserInformationUseCase: RemoveUserInformationUseCaseProtocol
    private let loginUseCase: LoginUseCaseProtocol
    private let saveUserLocalUseCase: SaveUserLocalUseCaseProtocol
    let buttonStatus = BehaviorRelay(value: CBButton.Status.enabled)
    var usernameText = BehaviorRelay(value: "")
    var passwordText = BehaviorRelay(value: "")
    let displayErrors = BehaviorRelay(value: false)

    init(_ removeUserInformationUseCase: RemoveUserInformationUseCaseProtocol,
         _ loginUseCase: LoginUseCaseProtocol,
         _ saveUserLocalUseCase: SaveUserLocalUseCaseProtocol)
    {
        self.removeUserInformationUseCase = removeUserInformationUseCase
        self.loginUseCase = loginUseCase
        self.saveUserLocalUseCase = saveUserLocalUseCase
    }

    func setCoordinator(_ coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }

    func removeInfo() {
        removeUserInformationUseCase.invoke().subscribe().disposed(by: disposeBag)
    }

    func goToHomeScreen() {
        coordinator?.goToHomeScreen()
    }

    // Login function that calls the login use case
    func login() {
        loadingRelay.accept(true)
        loginUseCase.invoke(usernameText.value, passwordText.value).subscribe(onSuccess: { user in
            self.goToHomeScreen()
            self.saveUserLocalUseCase.invoke(user)
            self.loadingRelay.accept(false)
            self.successRelay.accept(true)
        }, onFailure: { error in
            self.loadingRelay.accept(false)
            self.buttonStatus.accept(.disabled)
            self.handleError(error) {
                self.login()
            }
            print("loginError", error)
        }).disposed(by: disposeBag)
    }

    /// This function is called when the user taps the login button to get the username and password
    func setupLoginData(_ textFieldValue: String, _ passwordString: String) {
        usernameText.accept(textFieldValue)
        passwordText.accept(passwordString)
        if usernameText.value.count == 0 || passwordText.value.count == 0 {
            showErrorMessage("Please enter your username and password") {
                self.login()
            }
        } else {
//            login()
            // TODO: Remove this code and uncomment the above line
            /// This is just a temporary code to bypass the login screen as the login api throws a 400 and I do not have the model structure
            
            saveUserLocalUseCase.invoke(CBUser(id: "1",
                                               firstName: "Nicholas",
                                               lastName: "Wakaba",
                                               phone: Phone(number: "+254706502062", country: Country(regionCode: "KE", extensionCode: "254")),
                                               email: "nicolasbrown47@gmail.com",
                                               gender: "male"))
            goToHomeScreen()
        }
    }
}
