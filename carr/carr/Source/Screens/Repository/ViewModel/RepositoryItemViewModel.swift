//
//  RepositoryItemViewModel.swift
//  carr
//
//  Created by Márcio Abrantes on 19/06/23.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

public class RepositoryItemViewModel {
    public var repository: Repository?
    
    public var fullName: PublishSubject<String> = PublishSubject()
    public var description: PublishSubject<String?> = PublishSubject()
    public var createdAt: PublishSubject<String?> = PublishSubject()
    public var updatedAt: PublishSubject<String?> = PublishSubject()
    public var license: PublishSubject<String?> = PublishSubject()
    
    init(repository: Repository) {
        self.repository = repository
        self.fullName.onNext(repository.fullName)
        self.description.onNext(repository.description)
        self.createdAt.onNext(repository.createdAt)
        self.updatedAt.onNext(repository.updatedAt)
        self.license.onNext(repository.license?.key)
    }
}
