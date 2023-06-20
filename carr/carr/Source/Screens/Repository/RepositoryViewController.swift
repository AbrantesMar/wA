//
//  RepositoryController.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class RepositoryViewController: UIViewController {
    let viewModel: RepositoryViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var contentArea: UIView = {
        let contentArea = UIView()
        contentArea.translatesAutoresizingMaskIntoConstraints = false
        contentArea.isUserInteractionEnabled = true
        contentArea.backgroundColor = .white
        return contentArea
    }()
    
    private lazy var tableView: TableView = {
        let tableView = TableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        return tableView
    }()
    
    public init(viewModel: RepositoryViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension RepositoryViewController: ViewManager {
    public func bindViewModel() {
        tableView.tableView.rx.setDelegate(tableView.self).disposed(by: disposeBag)
        viewModel?
            .repositories
            .bind(to: tableView.tableView.rx.items(cellIdentifier: RepositoryTableViewCell.identifier, cellType: RepositoryTableViewCell.self)) { (row,item,cell) in
                print(item)
                cell.repositoryView.fullNameLabel.text = item.fullName
                cell.repositoryView.descriptionLabel.text = item.description
                cell.repositoryView.licenseKeyLabel.text = item.license?.key ?? ""
        }.disposed(by: disposeBag)
    }
    
    public func viewHierarchy() {
        view.addSubview(contentArea)
        contentArea.addSubview(tableView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            contentArea.topAnchor.constraint(equalTo: view.topAnchor),
            contentArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.heightAnchor.constraint(equalToConstant: 100),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentArea.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentArea.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentArea.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: contentArea.widthAnchor)
        ])
    }
    
}

extension RepositoryViewController: TableViewDelegate {
    
    public func selectedItem(indexPath: [Int]) {
    }
}
