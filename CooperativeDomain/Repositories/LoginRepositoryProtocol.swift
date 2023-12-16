//
//  LoginRepositoryProtocol.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

public protocol LoginRepositoryProtocol {
    func login(_ username: String, _ password: String) -> Single<(CBUser)>
}
