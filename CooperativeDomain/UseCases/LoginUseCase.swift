//
//  LoginUseCase.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

public class LoginUseCase: LoginUseCaseProtocol {
    private let loginRepository: LoginRepositoryProtocol

    public init(_ loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    public func invoke(_ username: String, _ password: String) -> Single<CBUser> {
        return loginRepository.login(username, password)
    }
}
