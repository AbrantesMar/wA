//
//  HomeViewModel.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Infra
import Domain
import RxSwift
import RxCocoa

public class HomeViewModel {
    private let usersList: UsersListProtocol
    public var users: [User] = []
    public var login: PublishSubject<String> = PublishSubject()
    public var loginSelected: String
    
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    
    init(usersList: UsersListProtocol) {
        self.usersList = usersList
        login.onNext("")
        loginSelected = ""
    }
    
    func fetchUsers() {
        usersList.fetchUsers() { [weak self] result in
            self?.handleFetchUsers(result: result)
        }
    }
    
    func handleFetchUsers(result: Result<[User]?, HttpError>) {
        switch result {
        case .success(let users):
            self.users = users ?? []
            self.reloadData?()
        case .failure(let error):
            self.showError?(error.localizedDescription)
        }
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func userAtIndex(_ index: Int) -> User {
        return users[index]
    }
}
