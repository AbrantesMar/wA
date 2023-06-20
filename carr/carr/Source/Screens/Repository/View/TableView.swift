//
//  TableView.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Domain
import UIKit

public protocol TableViewDelegate {
    func selectedItem(indexPath: [Int])
}

public class TableView: UIView {
    
    public var delegate: TableViewDelegate?
    private var selectedItem: Repository?

    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.allowsMultipleSelection = false
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableView: ViewManager {
    public func viewHierarchy() {
        super.addSubview(tableView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension TableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedItem(indexPath: [0])
    }
}
