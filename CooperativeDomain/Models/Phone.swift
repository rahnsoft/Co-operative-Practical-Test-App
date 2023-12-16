//
//  Phone.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//
import Foundation

public struct Phone {
    public var number: String
    public var country: Country

    public init(number: String, country: Country) {
        self.number = number
        self.country = country
    }

    public func formatted(withSpaces: Bool = true) -> String {
        if withSpaces {
            return "+\(country.extensionCode) \(number)"
        } else {
            return "+\(country.extensionCode)\(number)"
        }
    }
}
