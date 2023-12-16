//
//  BaseRemoteDataSource.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDomain
import RxSwift

class BaseRemoteDataSource {
    private let api: APIClient
    init() {
        api = APIClient()
    }

    func apiRequest<T: Codable>(_ urlRequest: URLRequest, isSecondTryAfterAuth: Bool = false) -> Single<(T, HTTPURLResponse)> {
        return api.request(urlRequest).catch { [unowned self] error in
            Single.create(subscribe: { [unowned self] single -> Disposable in
                if let cbError = parseError(error) {
                    single(.failure(cbError))
                } else {
                    single(.failure(error))
                }
                return Disposables.create()
            })
        }
    }

    func apiRequest(_ urlRequest: URLRequest, isSecondTryAfterAuth: Bool = false) -> Single<HTTPURLResponse> {
        return api.request(urlRequest).catch { [unowned self] error in
            singleError(error: error)
        }
    }

    private func parseError(_ error: Error) -> CBErrors? {
        return getSBError(error)
    }

    private func getSBError(_ error: Error) -> CBErrors? {
        return nil
    }

    private func singleError(error: Error) -> Single<HTTPURLResponse> {
        return Single.create(subscribe: { [unowned self] single -> Disposable in
            if let cbError = parseError(error) {
                single(.failure(cbError))
            } else {
                single(.failure(error))
            }
            return Disposables.create()
        })
    }
}
