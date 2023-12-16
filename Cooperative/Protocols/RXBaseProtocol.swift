//
//  RXBaseProtocol.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

// MARK: - RXBaseProtocol
/// Usage: disposeBag

protocol RxBaseProtocol {
    var disposeBag: DisposeBag { get }
}
