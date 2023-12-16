//
//  DependencyInjection.swift
//  CooperativeDependencyInjection
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Swinject
import CooperativeDomain

public class DependencyInjection {
    public static let shared = DependencyInjection()
    private var container: Container?

    private init() {}

    public func setContainer(_ container: Container) {
        self.container = container
    }

    public func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container?.resolve(serviceType) else {
            fatalError("Missing dependencies")
        }
        return service
    }
}
