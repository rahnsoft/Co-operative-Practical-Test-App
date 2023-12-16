//
//  PhoneRealModel.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RealmSwift
import CooperativeDomain

class PhoneRealmModel: Object, BaseDataModel {
    @objc dynamic var number: String = ""
    @objc dynamic var country: CountryRealmModel!

    convenience init(_ phone: Phone) {
        self.init()
        number = phone.number
        country = CountryRealmModel(phone.country)
    }

    func toDomainModel() -> Phone {
        return Phone(number: number, country: country.toDomainModel())
    }
}


