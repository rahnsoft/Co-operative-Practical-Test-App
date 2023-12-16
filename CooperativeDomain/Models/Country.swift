//
//  Country.swift
//  CooperativeDomain
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import UIKit

public struct Country {
    // MARK: Variables
    public var regionCode: String
    public var extensionCode: String
    public var name: String {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: regionCode) ?? ""
    }
    public var flag: String {
        return flag(regionCode: regionCode)
    }

    // MARK: Initializer
    public init() {
        self.regionCode = ""
        self.extensionCode = ""
    }

    public init(regionCode: String, extensionCode: String) {
        self.regionCode = regionCode
        self.extensionCode = extensionCode
    }

    // MARK: Private methods
    private func flag(regionCode: String) -> String {
        let base: UInt32 = 127397
        var scalar = ""
        for flagCode in regionCode.unicodeScalars {
            scalar.unicodeScalars.append(UnicodeScalar(base + flagCode.value)!)
        }
        return String(scalar)
    }
}
