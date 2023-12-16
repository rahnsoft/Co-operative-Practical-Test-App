//
//  UserRepositoryProtocol.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import RxSwift

public protocol UserRepositoryProtocol {
    func getUserLocal() -> Single<CBUser>
    func saveLocalUser(_ user: CBUser)
    func remove()
}
