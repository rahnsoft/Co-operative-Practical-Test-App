//
//  UserResponse.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDomain

public struct UserResponse: BaseDataModel, Codable {
    let id: String
    let firstName: String?
    let lastName: String?
    let phone: PhoneResponse?
    let email: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case phone
        case email
        case gender
    }

    init(id: String, firstName: String?, lastName: String?, phone: PhoneResponse?, email: String?, gender: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.gender = gender
    }

    func toDomainModel() -> CBUser {
        return CBUser(id: id,
                      firstName: firstName ?? "",
                      lastName: lastName ?? "",
                      phone: Phone(number: phone?.number ?? "",
                                   country: phone?.country.toDomainModel() ?? Country(regionCode: "", extensionCode: "")),
                      email: email ?? "",
                      gender: gender ?? "")
    }

    mutating func toDomainModel(with phone: Phone) -> CBUser {
        return toDomainModel()
    }
}
