//
//  Repository.swift
//  Domain
//
//  Created by Márcio Abrantes on 19/06/23.
//

public struct Repository: Model {
    public var nodeID: String
    public var name: String
    public var fullName: String
    public var description: String?
    public var accessPrivate: Bool
    public var createdAt: String?
    public var updatedAt: String?
    public var license: License?

    enum CodingKeys: String, CodingKey {
        case nodeID = "node_id"
        case name, description, createdAt, updatedAt, license
        case fullName = "full_name"
        case accessPrivate = "private"
    }
}
