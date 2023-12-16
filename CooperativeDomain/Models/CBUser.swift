//
//  CBUser.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//
import Foundation

public struct CBUser {
    public var id: String
    public var firstName: String
    public var lastName: String
    public var phone: Phone
    public var email: String?
    public var gender: String?
    
    public init(id: String, firstName: String, lastName: String, phone: Phone, email: String? = nil, gender: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.gender = gender
    }
}
