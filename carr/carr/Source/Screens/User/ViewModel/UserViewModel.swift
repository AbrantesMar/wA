//
//  UserViewModel.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Infra
import Domain
import RxSwift
import RxCocoa

public class UserViewModel {
    private var userName: String
    private var user: UserDetails?
    private let useCase: UserDetailsUseCaseProtocol
    
    var showError: ((String) -> Void)?
    
    var login: PublishSubject<String?> = PublishSubject()
    var name: PublishSubject<String?> = PublishSubject()
    var avatarURL: PublishSubject<URL?> = PublishSubject()
    var profileURL: PublishSubject<URL?> = PublishSubject()
    
    public init(useCase: UserDetailsUseCaseProtocol, userName: String) {
        self.useCase = useCase
        self.userName = userName
        self.fetchUser()
    }
    
    public func fetchUser() {
        useCase.fetchUser(userName: userName) { [weak self] result in
            self?.handleFetchUser(result: result)
        }
    }
    
    public func handleFetchUser(result: Result<UserDetails, HttpError>) {
        switch result {
        case .success(let user):
            self.user = user
            self.login.onNext(self.user?.login)
            self.name.onNext(self.user?.name)
            self.avatarURL.onNext(URL(string: self.user?.avatarURL ?? ""))
            self.profileURL.onNext(URL(string: self.user?.url ?? ""))
        case .failure(let error):
            self.showError?(error.localizedDescription)
        }
        
    }
}
