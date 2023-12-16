//
//  Container+Domain.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDomain
import Foundation
import Swinject

extension Container {
    public func registerDomainDependencies() {
        self.registerUseCases()
    }

    // MARK: Use Cases DI
    
    private func registerUseCases() {
        self.register(IsLoggedUseCase.self) { resolver in
            let getUserLocalUseCase = resolver.resolve(GetUserLocalUseCase.self)!
            let useCase = IsLoggedUseCase(getUserLocalUseCase)
            return useCase
        }
        
        self.register(GetUserLocalUseCase.self) { resolver in
            let repository = resolver.resolve(UserRepositoryProtocol.self)!
            let useCase = GetUserLocalUseCase(repository)
            return useCase
        }
        
        self.register(SaveUserUseCase.self) { resolver in
            let repository = resolver.resolve(UserRepositoryProtocol.self)!
            let useCase = SaveUserUseCase(repository)
            return useCase
        }
        
        self.register(RemoveUserInformationUseCase.self) { resolver in
            let repository = resolver.resolve(UserRepositoryProtocol.self)!
            let useCase = RemoveUserInformationUseCase(repository)
            return useCase
        }
        
        self.register(LoginUseCase.self) { resolver in
            let repository = resolver.resolve(LoginRepositoryProtocol.self)!
            let useCase = LoginUseCase(repository)
            return useCase
        }
    }
}
