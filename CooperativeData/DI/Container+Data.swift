//
//  Container+Data.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDomain
import Swinject

public extension Container {
    func registerDataDependencies() {
        self.registerRepositories()
    }

    // MARK: Repository DI

    func registerRepositories() {
        self.register(UserRepositoryProtocol.self) { _ in
            UserRepository()
        }

        self.register(LoginRepositoryProtocol.self) { _ in
            LoginRepository()
        }
    }
}
