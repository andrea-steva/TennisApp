//
//  RacketUpdateUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketUpdateUseCase {
    func execute(racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultRacketUpdateUseCase: RacketUpdateUseCase {

    // MARK: Properties

    private let racketsRepository: RacketsRepository

    // MARK: Init

    init(racketsRepository: RacketsRepository) {
        self.racketsRepository = racketsRepository
    }

    // MARK: Use case execution

    func execute(racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void) {
        racketsRepository.update(racket: racket, completion: completion)
    }
}
