//
//  HttpManagerProtocol.swift
//  Infra
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Alamofire

public protocol HttpManagerProtocol {
    var path: URL { get }
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get set }
    var body: [String: Any]? { get set }
}
