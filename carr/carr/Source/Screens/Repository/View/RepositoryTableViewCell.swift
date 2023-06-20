//
//  RepositoryTableViewCell.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import UIKit

public class RepositoryTableViewCell: UITableViewCell {
    static let identifier: String = "RepositoryTableViewCell"
    
    public lazy var repositoryView: RepositoryItemView = {
        let view = RepositoryItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RepositoryTableViewCell: ViewManager {
    public func bindViewModel() {
        
    }
    
    public func viewHierarchy() {
        self.contentView.addSubview(self.repositoryView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            repositoryView.topAnchor.constraint(equalTo: topAnchor),
            repositoryView.heightAnchor.constraint(equalToConstant: 100),
            repositoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            repositoryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            repositoryView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
