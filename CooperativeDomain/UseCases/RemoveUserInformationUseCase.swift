//
//  RemoveUserInformationUseCase.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

public class RemoveUserInformationUseCase: RemoveUserInformationUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol

    public init(_ userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    public func invoke() -> Completable {
        return Completable.create(subscribe: { [unowned self] completable -> Disposable in
            self.userRepository.remove()
            completable(.completed)
            return Disposables.create()
        })
    }
}
