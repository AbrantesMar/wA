//
//  RepositoryUseCase.swift
//  Infra
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Domain

public protocol RepositoryUseCaseProtocol {
    func fetchRepository(userName: String,
                   completion: @escaping (Result<[Repository], HttpError>) -> Void)
}

public final class RepositoryUseCase: RepositoryUseCaseProtocol {
    
    private let request: UserRequest
    private let httpClientProtocol: HttpClientProtocol
    
    public init(request: UserRequest,
                httpClientProtocol: HttpClientProtocol) {
        self.request = request
        self.httpClientProtocol = httpClientProtocol
    }
    
    public func fetchRepository(userName: String,
                          completion: @escaping (Result<[Repository], HttpError>) -> Void) {
        request.user = userName + "/repos"
        httpClientProtocol.fetchUserRepository(url: request.path,
                                         headers: request.headers) { [weak self] result in
            self?.handlerFetchRepository(result: result) { result in
                completion(result)
            }
        }
    }
    
    private func handlerFetchRepository(result: Result<[Repository], HttpError>,
                                  completion: @escaping (Result<[Repository], HttpError>) -> Void) {
        switch result {
        case .failure(_):
            completion(.failure(.badRequest))
        case .success(let root):
            completion(.success(root))
        }
    }
}
