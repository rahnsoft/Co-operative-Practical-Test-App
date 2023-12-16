//
//  HomeViewModel.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import RxSwift
import CooperativeDomain

class HomeViewModel: BaseViewModel {
    private let getUserLocalUseCase: GetUserLocalUseCaseProtocol
    private var coordinator: HomeCoordinator?
    
    init(_ getUserLocalUseCase: GetUserLocalUseCaseProtocol) {
        self.getUserLocalUseCase = getUserLocalUseCase
    }
    
    func setCoordinator(_ coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }

    func logout() {
        self.coordinator?.logout()
    }
    
    func fetchUser() -> Single<CBUser> {
        return getUserLocalUseCase.invoke()
    }
}
