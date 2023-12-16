//
//  LoginRepository.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift
import CooperativeDomain

public class LoginRepository: LoginRepositoryProtocol {
    private lazy var loginRemoteDataSource = LoginRemoteDataSource()

    public init() {}

    public func login(_ username: String, _ password: String) -> Single<CBUser> {
        return loginRemoteDataSource.login(username, password)
    }
}
