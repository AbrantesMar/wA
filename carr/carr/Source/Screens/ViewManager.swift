//
//  ViewManager.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation

public protocol ViewManager {
    func viewHierarchy()
    func setupConstraints()
    func bindViewModel()
}

public extension ViewManager {
    func setup() {
        viewHierarchy()
        setupConstraints()
        bindViewModel()
    }
    
    func bindViewModel() {}
    func viewHierarchy() {}
    func setupConstraints() {}
}

