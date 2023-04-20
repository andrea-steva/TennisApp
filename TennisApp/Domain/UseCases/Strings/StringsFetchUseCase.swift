//
//  StringsFetchUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// Represents the use case where `Strings` are fetched
protocol StringsFetchUseCase {
    func execute(racket: Racket,
                 completion: @escaping (Result<[Strings], Error>) -> Void)
}

final class DefaultStringsFetchUseCase: StringsFetchUseCase {

    // MARK: Properties

    private let stringsRepository: StringsRepository

    // MARK: Init

    init(stringsRepository: StringsRepository) {
        self.stringsRepository = stringsRepository
    }

    // MARK: Use case execution

    func execute(racket: Racket,
                 completion: @escaping (Result<[Strings], Error>) -> Void) {
        stringsRepository.fetch(forRacket: racket) { result in
            switch result {
            case .success(let strings):
                completion(.success(strings))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
