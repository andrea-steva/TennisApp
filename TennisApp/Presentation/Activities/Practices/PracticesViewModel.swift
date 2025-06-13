//
//  PracticesViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine

final class PracticesViewModel {

    // MARK: Use Cases

    // MARK: Data Source

    private var practices: [Practice] = []

    // MARK: Output

    var reloadViewData: AnyPublisher<Result<Void, Error>, Never> {
        reloadViewDataSubject.eraseToAnyPublisher()
    }

    private let reloadViewDataSubject = PassthroughSubject<Result<Void, Error>, Never>()

    // MARK: Methods

    init() {
    }

    func fetchPractices() {
        self.reloadViewDataSubject.send(.success(()))
    }

    func getPracticeViewModels() -> [PracticeViewModel] {
        practices.map { PracticeViewModel(practice: $0) }
    }

    func deletePractice(forIndex index: Int) {
    }
}
