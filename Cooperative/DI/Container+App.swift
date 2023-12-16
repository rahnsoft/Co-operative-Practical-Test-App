//
//  Container.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeData
import CooperativeDomain
import Swinject

extension Container {
    func registerAppDependencies() {
        self.registerViewModelDependencies()
    }
    
    private func registerViewModelDependencies() {
        self.register(HomeViewModel.self) { resolver in
            let getUserLocalUseCase = resolver.resolve(GetUserLocalUseCase.self)!
            let viewModel = HomeViewModel(getUserLocalUseCase)
            return viewModel
        }
        
        self.register(LoginViewModel.self) { resolver in
            let removeUserInformationUseCase = resolver.resolve(RemoveUserInformationUseCase.self)!
            let loginUseCase = resolver.resolve(LoginUseCase.self)!
            let saveUserLocalUseCase = resolver.resolve(SaveUserUseCase.self)!
            let viewModel = LoginViewModel(removeUserInformationUseCase,
                                           loginUseCase,
                                           saveUserLocalUseCase)
            return viewModel
        }
    }
}
