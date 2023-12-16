//
//  CountryRealModel.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RealmSwift
import CooperativeDomain

class CountryRealmModel: Object, BaseDataModel {
    @objc dynamic var regionCode: String = ""
    @objc dynamic var extensionCode: String = ""

    convenience init(_ country: Country) {
        self.init()
        regionCode = country.regionCode
        extensionCode = country.extensionCode
    }

    func toDomainModel() -> Country {
        return Country(regionCode: regionCode, extensionCode: extensionCode)
    }
}
