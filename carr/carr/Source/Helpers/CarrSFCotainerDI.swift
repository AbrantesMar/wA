//
//  CarrSFCotainerDI.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation

protocol CarrSFCotainerDIContainerDIProtocol {
    func register<T>(type: T.Type, component: Any)
    func resolve<T>(type: T.Type) -> T?
}

public class CarrSFCotainerDI {
    static let shared = CarrSFCotainerDI()

    private init() {}

    var services: [String: Any] = [:]

    func register<T>(type: T.Type, service: Any) {
        services["\(type)"] = service
    }

    func resolve<T>(type: T.Type) -> T {
        return services["\(type)"] as! T
    }
}
