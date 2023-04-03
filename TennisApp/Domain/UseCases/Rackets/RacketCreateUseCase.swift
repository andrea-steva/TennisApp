//
//  RacketCreateUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketCreateUseCase {
    func execute(racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultRacketCreateUseCase: RacketCreateUseCase {

    // MARK: Properties

    private let racketsRepository: RacketsRepository

    // MARK: Init

    init(racketsRepository: RacketsRepository) {
        self.racketsRepository = racketsRepository
    }

    // MARK: Use case execution

    func execute(racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void) {
        racketsRepository.create(racket: racket, completion: completion)
    }
}

