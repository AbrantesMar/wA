//
//  License.swift
//  Domain
//
//  Created by Márcio Abrantes on 19/06/23.
//

public struct License: Model {
    public var key: String?
    
    enum CodingKeys: String, CodingKey {
        case key
    }
}
