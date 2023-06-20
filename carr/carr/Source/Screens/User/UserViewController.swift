//
//  UserViewController.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public protocol UserVeiwControllerDelegate {
    func goRepositories(userName: String)
}

public class UserViewController: UIViewController {
    public let viewModel: UserViewModel
    public var delegate: UserVeiwControllerDelegate?
    private let disposeBag = DisposeBag()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Repositorios", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(viewProfileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loaging: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Usuário"
        view.backgroundColor = .white
        self.showSpinner()
        setup()
        
    }
    
    @objc private func viewProfileButtonTapped() {
        delegate?.goRepositories(userName: loginLabel.text ?? "")
    }

    private func showSpinner() {
        self.loaging.startAnimating()
        self.loaging.isHidden = false
    }

    private func hideSpinner() {
        self.loaging.stopAnimating()
        self.loaging.isHidden = true
    }
}

extension UserViewController: ViewManager {
    public func bindViewModel() {
        viewModel.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.login
            .bind(to: loginLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.avatarURL
            .subscribe(onNext: { [weak self] url in
            DispatchQueue.global().async {
                guard let url = url else {
                    return
                }
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self?.avatarImageView.image = UIImage(data: imageData)
                        self?.hideSpinner()
                    }
                }
            }
        })
        .disposed(by: disposeBag)
    }
    
    public func viewHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(loginLabel)
        view.addSubview(avatarImageView)
        view.addSubview(loaging)
        view.addSubview(profileButton)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            loginLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 16),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            loaging.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
            loaging.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loaging.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loaging.heightAnchor.constraint(equalToConstant: 200),
            
            avatarImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),
            
            profileButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        
    }
}

