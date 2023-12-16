//
//  APIClient.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Alamofire
import RxAlamofire
import RxSwift
import enum CooperativeDomain.CBErrors
#if DEBUG
import Log
import Foundation
#endif

enum DateError: String, Error {
    case invalidDate
}

public class APIClient {
    private var sessionManager: Session
#if DEBUG
    let log: Logger = Logger()
#endif

    public init() {
        sessionManager = Session()
    }

    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { (response, urlResponse) in
                    observer(.success((response, urlResponse)))
                }, { (error) in
                    observer(.failure(error))
                })
            } else {
                observer(.failure(CBErrors.internetError))
                return Disposables.create()
            }
        })
    }

    func request(_ urlRequest: URLRequest) -> Single<(HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { (urlResponse) in
                    observer(.success((urlResponse)))
                }, { (error) in
                    observer(.failure(error))
                })
            } else {
                observer(.failure(CBErrors.internetError))
                return Disposables.create()
            }
        })
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest,
                                       _ responseHandler: @escaping (T, HTTPURLResponse) -> Void,
                                       _ errorHandler: @escaping ((_ error: CBErrors) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (response) in
                guard let self = self else { return }
                guard let httpUrlResponse = response.response else {
                    return
                }
                let statusCode = httpUrlResponse.statusCode
                    guard let data = response.data else { return }
                    self.decode(data, statusCode: statusCode, errorHandler)
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func request(_ urlRequest: URLRequest,
                         _ responseHandler: @escaping (HTTPURLResponse) -> Void,
                         _ errorHandler: @escaping ((_ error: CBErrors) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseData()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (httpUrlResponse, data) in
                    guard let self = self else { return }
                    self.logError(urlRequest, response: httpUrlResponse)
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func decode(_ data: Data, statusCode: Int, _ errorHandler: ((_ error: CBErrors) -> Void)) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            errorHandler(CBErrors.apiError(code: errorResponse.code ?? statusCode,
                                           message: errorResponse.message ?? "",
                                           reason: errorResponse.reason ?? "",
                                           dict: jsonObject))
        } catch {
            errorHandler(.parseData)
        }
    }

    func logError(_ urlRequest: URLRequest, response: HTTPURLResponse) {
#if DEBUG
        log.error(urlRequest)
        log.error(urlRequest.allHTTPHeaderFields ?? [:])
        log.error(response)
#endif
    }
}
