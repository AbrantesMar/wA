//
//  AppDelegateFlowController.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import UIKit
import Domain

public class AppDelegateFlowController: UIViewController {
    public var navigation: UINavigationController?
    
    public override func viewDidLoad() {
        start()
    }
    
    public func start() {
        CarrSFFactory.makeRegisterServices()
        super.viewDidLoad()
        if self.navigation == nil {
            let viewModel = HomeViewModel(usersList: CarrSFFactory.makeUsers())
            let homeViewController = HomeViewController(viewModel: viewModel)
            homeViewController.delegate = self
            let uiNavigationController = UINavigationController(rootViewController: homeViewController)
            uiNavigationController.setNavigationBarHidden(false, animated: true)
            self.navigation = uiNavigationController
        }
    }
    
    public func goUserView(userName: String) {
        let viewModel = UserViewModel(useCase: CarrSFFactory.makeUserUseCase(), userName: userName)
        let userView = UserViewController(viewModel: viewModel)
        userView.delegate = self
                
        navigation?.pushViewController(userView, animated: true)
    }
    
    public func goRepositoryView(userName: String) {
        let viewModel = RepositoryViewModel(useCase: CarrSFFactory.makeRepositoryUseCase(), userName: userName)
        viewModel.fetchRepositories()
        let repositories = RepositoryViewController(viewModel: viewModel)
        
        navigation?.pushViewController(repositories, animated: true)
    }
}

extension AppDelegateFlowController: HomeViewControllerDelegate {
    func didSelectUser(user: User) {
        let path = "/" + user.login
        goUserView(userName: path)
    }
}

extension AppDelegateFlowController: UserVeiwControllerDelegate {
    public func goRepositories(userName: String) {
        let path = "/" + userName
        goRepositoryView(userName: path)
    }
}

