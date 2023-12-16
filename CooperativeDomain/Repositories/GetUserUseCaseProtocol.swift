//
//  GetUserUseCaseProtocol.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

public protocol GetUserLocalUseCaseProtocol {
    func invoke() -> Single<CBUser>
}
