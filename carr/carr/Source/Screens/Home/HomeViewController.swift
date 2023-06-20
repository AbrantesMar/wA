//
//  HomeViewController.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import UIKit
import Infra
import Domain
import RxSwift

protocol HomeViewControllerDelegate: AnyObject {
    func didSelectUser(user: User)
}

public class HomeViewController: UIViewController {
    
    public var viewModel: HomeViewModel
    weak var delegate: HomeViewControllerDelegate?
    let disposeBag = DisposeBag()
    
    private lazy var content: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = .white
        return content
    }()
    
    private lazy var textFilterTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.viewModel.showError = { [weak self] error in
            let alert = UIAlertController(title: "Verifique sua internet", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                alert.dismiss(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Tente novamente", style: .default, handler: { action in
                self?.viewModel.fetchUsers()
                self?.tableView.reloadData()
                alert.dismiss(animated: true)
            }))
            self?.present(alert, animated: true)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.viewModel.fetchUsers()
    }
}

extension HomeViewController: ViewManager {
    public func bindViewModel() {
        viewModel
            .login
            .bind(to: textFilterTextField.rx.text).disposed(by: disposeBag)
    }
    public func viewHierarchy() {
        title = "Users"
        view.addSubview(content)
        content.addSubview(textFilterTextField)
        content.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            
            content.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textFilterTextField.topAnchor.constraint(equalTo: content.topAnchor),
            textFilterTextField.heightAnchor.constraint(equalToConstant: 50),
            textFilterTextField.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            textFilterTextField.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            textFilterTextField.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: textFilterTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: content.bottomAnchor)
        ])
    }
    
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = viewModel.userAtIndex(indexPath.row)
        cell.textLabel?.text = user.login
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.userAtIndex(indexPath.row)
        delegate?.didSelectUser(user: user)
    }
}
