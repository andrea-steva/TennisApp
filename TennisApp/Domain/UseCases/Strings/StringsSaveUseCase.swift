//
//  StringsSaveUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringsSaveUseCase {
    func execute(string: Strings,
                 racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultStringsSaveUseCase: StringsSaveUseCase {

    // MARK: Properties

    private let stringsRepository: StringsRepository

    // MARK: Init

    init(stringsRepository: StringsRepository) {
        self.stringsRepository = stringsRepository
    }

    // MARK: Use case execution

    func execute(string: Strings,
                 racket: Racket,
                 completion: @escaping (Result<Bool, Error>) -> Void) {
        stringsRepository.save(string: string, forRacket: racket, completion: completion)
    }
}
