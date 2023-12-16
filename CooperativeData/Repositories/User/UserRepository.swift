//
//  UserRepository.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift
import CooperativeDomain

public class UserRepository: UserRepositoryProtocol {
    private let userLocalDataSource: UserLocalDataSource

    init() {
        userLocalDataSource = UserLocalDataSource()
    }
    
    public func getUserLocal() -> Single<CBUser> {
        return userLocalDataSource.getUser()
    }
    
    public func saveLocalUser(_ user: CBUser) {
        userLocalDataSource.saveUser(user)
    }
    
    public func remove() {
        userLocalDataSource.removeUser()
    }
}
