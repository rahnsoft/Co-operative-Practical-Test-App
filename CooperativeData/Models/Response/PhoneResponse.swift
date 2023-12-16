//
//  PhoneResponse.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation
import CooperativeDomain

struct PhoneResponse:  BaseDataModel, Codable {
    let number: String
    let country: CountryResponse
    
    enum CodingKeys: String, CodingKey {
        case number
        case country
    }
    
    init(number: String, country: CountryResponse) {
        self.number = number
        self.country = country
    }
    
    func toDomainModel() -> Phone {
        return Phone(number: number, country: country.toDomainModel())
    }
    
    mutating func toDomainModel(with phone: Phone) -> Phone {
        return toDomainModel()
    }
}
