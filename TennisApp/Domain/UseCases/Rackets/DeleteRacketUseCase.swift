//
//  DeleteRacketUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketDeleteUseCase {
    func execute(racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultRacketDeleteUseCase: RacketDeleteUseCase {

    // MARK: Properties

    private let racketsRepository: RacketsRepository

    // MARK: Init

    init(racketsRepository: RacketsRepository) {
        self.racketsRepository = racketsRepository
    }

    // MARK: Use case execution

    func execute(racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void) {
        racketsRepository.deleteRackets(completion: completion)
    }
}
