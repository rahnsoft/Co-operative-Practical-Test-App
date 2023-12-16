//
//  LoginRemoteDataSource.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//
import CooperativeDomain
import RxSwift

class LoginRemoteDataSource: BaseRemoteDataSource {
    func login(_ username: String, _ password: String) -> Single<CBUser> {
        requestAccount(username, password).map { user, _ -> CBUser in
            user.toDomainModel()
        }
    }

    func requestAccount(_ username: String, _ password: String) -> Single<(UserResponse, HTTPURLResponse)> {
        let parameters: [String: Any] = ["username": username, "password": password]
        let urlRequest = URLRequest(.auth, .post, parameters)
        return apiRequest(urlRequest)
    }
}
