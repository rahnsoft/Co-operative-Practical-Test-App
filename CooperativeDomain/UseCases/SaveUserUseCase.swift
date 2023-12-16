//
//  SaveUserUseCase.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
public class SaveUserUseCase: SaveUserLocalUseCaseProtocol {
    
    private let userRepository: UserRepositoryProtocol

    public init(_ userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    public func invoke(_ user: CBUser) {
        userRepository.saveLocalUser(user)
    }
}
