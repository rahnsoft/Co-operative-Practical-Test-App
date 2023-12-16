//
//  LoginCoordinator.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import UIKit
import CooperativeDomain
import CooperativeDependencyInjection

class LoginCoordinator {
    private let window: UIWindow?
    private var navigationController: UINavigationController
    private var loginViewModel: LoginViewModel!
    private var loginViewController: LoginViewController!

    init(_ window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        let removeUserInformationUseCase = DependencyInjection.shared.resolve(RemoveUserInformationUseCase.self)
        let loginUseCase = DependencyInjection.shared.resolve(LoginUseCase.self)
        let saveUserUseCase = DependencyInjection.shared.resolve(SaveUserUseCase.self)
        loginViewModel = LoginViewModel(removeUserInformationUseCase, loginUseCase, saveUserUseCase)
        loginViewModel.setCoordinator(self)
        loginViewController = LoginViewController(loginViewModel)
        navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func goToHomeScreen() {
        HomeCoordinator(window).start()
    }
}
