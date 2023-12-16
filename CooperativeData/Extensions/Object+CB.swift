//
//  Object+CB.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import RealmSwift

extension Object {
    @objc func save(_ update: Bool) {
        do {
            let realm = RealmFactory().realmInstance()
            realm.beginWrite()
            realm.add(self, update: update ? .all : .error)
            try realm.commitWrite()
        } catch {}
    }

    func deleteFromRealm() {
        do {
            let realm = RealmFactory().realmInstance()
            realm.beginWrite()
            realm.delete(self)
            try realm.commitWrite()
        } catch {}
    }
}
