//
//  UserDetails.swift
//  Domain
//
//  Created by Márcio Abrantes on 19/06/23.
//

public struct UserDetails: Model {
    public var login: String
    public var id: Int
    public var url: String
    public var name: String
    public var nodeID: String
    public var avatarURL: String
    public var gravatarID: String
    public var type: String
    public var siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id, url, name
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case type
        case siteAdmin = "site_admin"
    }
}
