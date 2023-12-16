//
//  ConfigurationLocalDataSource.swift
//  CooperativeData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation

class ConfigurationLocalDataSource: ConfigurationLocalDataSourceProtocol {
    private let localDefaults: LocalDefaultsDataSource

    init() {
        localDefaults = LocalDefaultsDataSource()
    }
    
    
}
