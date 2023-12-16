//
//  UserLocalDataSource.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDomain
import RealmSwift
import RxSwift

public class UserLocalDataSource {
    func saveUser(_ user: CBUser) {
        let userRealmModel = UserRealmModel(user)
        userRealmModel.save(true)
    }

    func getUser() -> Single<CBUser> {
        return Single.create(subscribe: { [unowned self] single -> Disposable in
            do {
                let userRealmModel = try self.getUserRealmModel()
                single(.success(userRealmModel.toDomainModel()))
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        })
    }

    private func getUserRealmModel() throws -> UserRealmModel {
        let realm = RealmFactory().realmInstance()
        guard let userRealmModel = realm.objects(UserRealmModel.self).first else {
            throw CBErrors.localUserNotFound
        }
        return userRealmModel
    }
    
    func removeUser() {
        do {
            let userRealmModel = try getUserRealmModel()
            userRealmModel.deleteFromRealm()
        } catch {}
    }
}
