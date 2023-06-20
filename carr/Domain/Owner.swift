//
//  Owner.swift
//  Domain
//
//  Created by Márcio Abrantes on 19/06/23.
//

public struct Owner: Model {
    var login: String
    var id: Int

    enum CodingKeys: String, CodingKey {
        case login, id
    }
}
