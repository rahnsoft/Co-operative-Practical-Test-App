//
//  LoginUseCaseProtocol.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

public protocol LoginUseCaseProtocol {
    func invoke(_ username: String, _ password: String) -> Single<(CBUser)>
}

