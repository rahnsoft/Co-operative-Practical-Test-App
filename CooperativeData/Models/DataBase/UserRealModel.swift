//
//  UserRealModel.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RealmSwift
import CooperativeDomain

class UserRealmModel: Object, BaseDataModel {
    @objc dynamic var id: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var email: String?
    @objc dynamic var phone: PhoneRealmModel!
    @objc dynamic var gender: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ user: CBUser) {
        self.init()
        id = user.id
        firstName = user.firstName
        lastName = user.lastName
        email = user.email
        phone = PhoneRealmModel(user.phone)
        gender = gender
        
    }
    
    func toDomainModel() -> CBUser {
        return CBUser(id: id,
                      firstName: firstName,
                      lastName: lastName,
                      phone: phone.toDomainModel(),
                      email: email,
                      gender: gender)
    }
}
