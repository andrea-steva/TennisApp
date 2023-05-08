//
//  MatchesViewModel.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 08/04/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine

final class MatchesViewModel {

    // MARK: Use Cases

    // MARK: Data Source

    private var matches: [Match] = [ Match(identifier: "1",
                                           name: "",
                                           notes: "",
                                           place: "",
                                           timeSpent: 1,
                                           date: nil, playerNameA: "", playerNameB: "", matchType: .single, user: nil, scores: [])
    ]

    // MARK: Output

    var reloadViewData: AnyPublisher<Result<Void, Error>, Never> {
        reloadViewDataSubject.eraseToAnyPublisher()
    }

    private let reloadViewDataSubject = PassthroughSubject<Result<Void, Error>, Never>()

    // MARK: Methods

    init() {
    }

    func fetchMatches() {
        self.reloadViewDataSubject.send(.success(()))
    }

    func getMatchesViewModels() -> [MatchViewModel] {
        matches.map { MatchViewModel(match: $0) }
    }

    func deleteMatch(forIndex index: Int) {
    }
}
