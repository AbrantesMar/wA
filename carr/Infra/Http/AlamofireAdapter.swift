//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Alamofire
import Domain

public protocol HttpClientProtocol {
    func fetchUserList(url: URL, headers: HTTPHeaders?,
                       completion: @escaping (Result<[User]?, HttpError>) -> Void)
    func fetchUser(url: URL,
                   headers: HTTPHeaders?,
                   completion: @escaping (Result<UserDetails, HttpError>) -> Void)
    func fetchUserRepository(url: URL,
                          headers: HTTPHeaders?,
                          completion: @escaping (Result<[Repository], HttpError>) -> Void)
}

public final class AlamofireAdapter: HttpClientProtocol {

    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func fetchUserList(url: URL,
                              headers: HTTPHeaders?,
                              completion: @escaping (Result<[User]?, HttpError>) -> Void) {
        session.request(url)
            .validate(statusCode: 200...300)
            .responseDecodable(of: [User].self) { [weak self] response in
                self?.handleUserList(user: response.value) { result in
                    completion(result)
                }
        }
    }
    
    public func fetchUserRepository(url: URL,
                          headers: HTTPHeaders?,
                          completion: @escaping (Result<[Repository], HttpError>) -> Void) {

        session.request(url)
            .validate(statusCode: 200...300)
            .responseDecodable(of: [Repository].self) { [weak self] response in
                self?.handleRepository(repositorys: response.value) { result in
                    completion(result)
                }
        }
    }
    
    func handleUserList(user: [User]?,
                        completion: @escaping (Result<[User]?, HttpError>) -> Void) {
        guard let user = user else {
            return completion(.failure(.badRequest))
        }
        completion(.success(user))
    }

    public func fetchUser(url: URL,
                          headers: HTTPHeaders?,
                          completion: @escaping (Result<UserDetails, HttpError>) -> Void) {

        session.request(url, headers: headers)
            .validate(statusCode: 200...300)
            .responseDecodable(of: UserDetails.self) { [weak self] response in
            self?.handleApiUserResult(url: url, headers: headers, result: response) { result in
                completion(result)
            }
        }
    }
    
    func handleRepository(repositorys: [Repository]?,
                          completion: @escaping (Result<[Repository], HttpError>) -> Void) {
        guard let repositorys = repositorys else {
            return completion(.failure(.badRequest))
        }
        completion(.success(repositorys))
    }
    
    func handleApiUserResult(url: URL, headers: HTTPHeaders?,
                         result: AFDataResponse<UserDetails>,
                         completion: @escaping (Result<UserDetails, HttpError>) -> Void) {
        do {
            switch result.result {
            case .failure(_):
                completion(.failure(.badRequest))
            case .success(let root):
                completion(.success(root))
            }
        } catch let error as DecodingError {
           switch error {
                case .typeMismatch(let key, let value):
                  print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                case .valueNotFound(let key, let value):
                  print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                case .keyNotFound(let key, let value):
                  print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                case .dataCorrupted(let key):
                  print("error \(key), and ERROR: \(error.localizedDescription)")
                default:
                  print("ERROR: \(error.localizedDescription)")
                }
           }
    }
}
