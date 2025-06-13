//
//  StringsDeleteUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 07/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringsDeleteUseCase {
    func execute(string: Strings,
                 completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultStringsDeleteUseCase: StringsDeleteUseCase {

    // MARK: Properties

    private let stringsRepository: StringsRepository

    // MARK: Init

    init(stringsRepository: StringsRepository) {
        self.stringsRepository = stringsRepository
    }

    // MARK: Use case execution

    func execute(string: Strings,
                 completion: @escaping (Result<Bool, Error>) -> Void) {
        stringsRepository.delete(string: string, completion: completion)
    }
}
