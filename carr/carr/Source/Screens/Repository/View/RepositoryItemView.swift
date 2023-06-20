//
//  RepositoryItemView.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import UIKit
import RxSwift

public class RepositoryItemView: UIView {
    
    public var viewModel: RepositoryItemViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var contentArea: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var fullNameLabel: UILabel = {
        let titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let titleView = UILabel()
        titleView.lineBreakMode = .byWordWrapping
        titleView.numberOfLines = 0
        //titleView.preferredMaxLayoutWidth = width
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    public lazy var licenseKeyLabel: UILabel = {
        let titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RepositoryItemView: ViewManager {
    public func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.fullName.bind(to: fullNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.description.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.license.bind(to: licenseKeyLabel.rx.text).disposed(by: disposeBag)
    }
    
    public func viewHierarchy() {
        super.addSubview(contentArea)
        contentArea.addSubview(fullNameLabel)
        contentArea.addSubview(descriptionLabel)
        contentArea.addSubview(licenseKeyLabel)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            contentArea.widthAnchor.constraint(equalTo: widthAnchor),
            contentArea.heightAnchor.constraint(equalTo: heightAnchor),
            contentArea.topAnchor.constraint(equalTo: topAnchor),
            contentArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            fullNameLabel.widthAnchor.constraint(equalTo: contentArea.widthAnchor),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            fullNameLabel.topAnchor.constraint(equalTo: contentArea.topAnchor),
            fullNameLabel.leadingAnchor.constraint(equalTo: contentArea.leadingAnchor),
            
            descriptionLabel.widthAnchor.constraint(equalTo: contentArea.widthAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 60),
            descriptionLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentArea.leadingAnchor),

            licenseKeyLabel.widthAnchor.constraint(equalTo: contentArea.widthAnchor),
            licenseKeyLabel.heightAnchor.constraint(equalToConstant: 20),
            licenseKeyLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            licenseKeyLabel.bottomAnchor.constraint(equalTo: contentArea.bottomAnchor),
            licenseKeyLabel.leadingAnchor.constraint(equalTo: contentArea.leadingAnchor)
        ])
    }
}

