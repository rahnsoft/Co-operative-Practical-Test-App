//
//  IsLoggedUseCase.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import RxSwift

public class IsLoggedUseCase: IsLoggedUseCaseProtocol {
    private let getUserLocalUseCase: GetUserLocalUseCaseProtocol

    public init(_ getUserLocalUseCase: GetUserLocalUseCaseProtocol) {
        self.getUserLocalUseCase = getUserLocalUseCase
    }

    public func invoke() -> Single<Bool> {
        return getUserLocalUseCase.invoke().flatMap { _ in
            .just(true)
        }.catch { error in
            if case CBErrors.localUserNotFound = error {
                return .just(false)
            } else {
                return .error(error)
            }
        }
    }
}
