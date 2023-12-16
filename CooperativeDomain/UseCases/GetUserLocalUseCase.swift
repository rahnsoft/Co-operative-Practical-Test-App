//
//  GetUserLocalUseCase.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

public class GetUserLocalUseCase: GetUserLocalUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol

    public init(_ userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    public func invoke() -> Single<CBUser> {
        return userRepository.getUserLocal()
    }
}
