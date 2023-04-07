//
//  StringsDIContainer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 04/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class StringsDIContainer {

    // MARK: Local Storage

    private lazy var stringsCoreDataStorage = StringsCoreDataStorage()

    // MARK: UseCases

    func makeStringsFetchUseCase() -> StringsFetchUseCase {
        DefaultStringsFetchUseCase(stringsRepository: makeStringsRepository())
    }

    func makeStringsCreateUseCase() -> StringsCreateUseCase {
        DefaultStringsCreateUseCase(stringsRepository: makeStringsRepository())
    }

    func makeStringsUpdateUseCase() -> StringsUpdateUseCase {
        DefaultStringsUpdateUseCase(stringsRepository: makeStringsRepository())
    }

    func makeStringsDeleteUseCase() -> StringsDeleteUseCase {
        DefaultStringsDeleteUseCase(stringsRepository: makeStringsRepository())
    }

    // MARK: Repositories

    private func makeStringsRepository() -> StringsRepository {
        DefaultStringsRepository(stringsLocalStorage: stringsCoreDataStorage)
    }
}
