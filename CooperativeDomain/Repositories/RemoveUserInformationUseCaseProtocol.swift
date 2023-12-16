//
//  RemoveUserInformationUseCaseProtocol.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

public protocol RemoveUserInformationUseCaseProtocol {
    func invoke() -> Completable
}
