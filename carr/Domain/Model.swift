//
//  Model.swift
//  Domain
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation

public protocol Model: Codable { }

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
