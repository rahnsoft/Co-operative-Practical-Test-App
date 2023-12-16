//
//  CountryResponse.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import CooperativeDomain

struct CountryResponse:  BaseDataModel, Codable {
    let name: String
    let extensionCode: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case extensionCode
    }
    
    init(name: String, extensionCode: String) {
        self.name = name
        self.extensionCode = extensionCode
    }
    
    func toDomainModel() -> Country {
        return Country(regionCode: name, extensionCode: extensionCode)
    }
    
    mutating func toDomainModel(with country: Country) -> Country {
        return toDomainModel()
    }
}
