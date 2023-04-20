//
//  RacketsFetchUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// Represents the use case where `Rackets` are fetched
protocol RacketsFetchUseCase {
    func execute(completion: @escaping (Result<[Racket], Error>) -> Void)
}

final class DefaultRacketsFetchUseCase: RacketsFetchUseCase {

    // MARK: Properties

    private let racketsRepository: RacketsRepository

    // MARK: Init

    init(racketsRepository: RacketsRepository) {
        self.racketsRepository = racketsRepository
    }

    // MARK: Use case execution

    func execute(completion: @escaping (Result<[Racket], Error>) -> Void) {
        racketsRepository.fetch { result in
            switch result {
            case .success(let rackets):
                completion(.success(rackets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
