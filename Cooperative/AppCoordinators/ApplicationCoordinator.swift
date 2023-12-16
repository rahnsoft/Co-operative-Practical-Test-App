//
//  ApplicationCoordinator.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDependencyInjection
import CooperativeDomain
import RxSwift

class ApplicationCoordinator {
    private let window: UIWindow?
    private let isLoggedUseCase: IsLoggedUseCase
    private let disposeBag = DisposeBag()

    required init(_ window: UIWindow?) {
        self.window = window
        isLoggedUseCase = DependencyInjection.shared.resolve(IsLoggedUseCase.self)
    }

    func start() {
        isLoggedUseCase.invoke().subscribe(onSuccess: { [weak self] isLogged in
            guard let self = self else { return }
            if isLogged {
                self.goToHomeScreen()
            } else {
                self.startLogin()
            }
        }, onFailure: { [weak self] _ in
            guard let self = self else { return }
            self.startLogin()
        }).disposed(by: disposeBag)
    }

    private func startLogin() {
        guard let window = window else {
            return
        }
        LoginCoordinator(window).start()
    }

    private func goToHomeScreen() {
        guard let window = window else {
            return
        }
        HomeCoordinator(window).start()
    }
}
