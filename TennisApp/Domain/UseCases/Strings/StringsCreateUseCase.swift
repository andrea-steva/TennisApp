//
//  StringsCreateUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringsCreateUseCase {
    func execute(string: Strings,
                 completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultStringsCreateUseCase: StringsCreateUseCase {

    // MARK: Properties

    private let stringsRepository: StringsRepository

    // MARK: Init

    init(stringsRepository: StringsRepository) {
        self.stringsRepository = stringsRepository
    }

    // MARK: Use case execution

    func execute(string: Strings,
                 completion: @escaping (Result<Bool, Error>) -> Void) {
        stringsRepository.create(string: string, completion: completion)
    }
}
