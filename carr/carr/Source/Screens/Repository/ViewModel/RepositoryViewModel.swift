//
//  RepositoryViewModel.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Infra
import Domain
import RxSwift
import RxCocoa

public class RepositoryViewModel {
    public var repositories: PublishSubject<[Repository]> = PublishSubject()
    private let useCase: RepositoryUseCaseProtocol
    private var userName: String
    
    var showError: ((String) -> Void)?
    
    public init(useCase: RepositoryUseCaseProtocol, userName: String) {
        self.useCase = useCase
        self.userName = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchRepositories() {
        useCase.fetchRepository(userName: userName) { [weak self] result in
            self?.handleFetchUser(result: result)
        }
    }
    
    public func handleFetchUser(result: Result<[Repository], HttpError>) {
        switch result {
        case .success(let respositories):
            self.repositories.onNext(respositories)
        case .failure(let error):
            self.showError?(error.localizedDescription)
        }
    }
}
