//
//  UsersList.swift
//  Infra
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Domain

public protocol UsersListProtocol {
    func fetchUsers(completion: @escaping (Result<[User]?, HttpError>) -> Void)
}

public final class UsersList: UsersListProtocol {
    
    private let request: UserRequest
    private let httpClientProtocol: HttpClientProtocol
    
    public init(request: UserRequest, httpClientProtocol: HttpClientProtocol) {
        self.request = request
        self.httpClientProtocol = httpClientProtocol
    }
    
    public func fetchUsers(completion: @escaping (Result<[User]?, HttpError>) -> Void) {
        httpClientProtocol.fetchUserList(url: request.path,
                                         headers: request.headers) { [weak self] result in
            self?.handlerFetUserList(result: result) { result in
                completion(result)
            }
        }
    }
    
    private func handlerFetUserList(result: Result<[User]?, HttpError>,
                                    completion: @escaping (Result<[User]?, HttpError>) -> Void) {
        switch result {
        case .failure(_):
            completion(.failure(.badRequest))
        case .success(let root):
            completion(.success(root))
        }
    }
}
