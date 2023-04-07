//
//  DIContainer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 04/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class RacketsDIContainer {

    // MARK: Local Storage

    private lazy var racketsCoreDataStorage = RacketsCoreDataStorage()

    // MARK: UseCases

    func makeRacketsFetchUseCase() -> RacketsFetchUseCase {
        DefaultRacketsFetchUseCase(racketsRepository: makeRacketsRepository())
    }

    func makeRacketCreateUseCase() -> RacketCreateUseCase {
        DefaultRacketCreateUseCase(racketsRepository: makeRacketsRepository())
    }

    func makeRacketUpdateUseCase() -> RacketUpdateUseCase {
        DefaultRacketUpdateUseCase(racketsRepository: makeRacketsRepository())
    }

    func makeRacketDeleteUseCase() -> RacketDeleteUseCase {
        DefaultRacketDeleteUseCase(racketsRepository: makeRacketsRepository())
    }

    // MARK: Repositories

    private func makeRacketsRepository() -> RacketsRepository {
        DefaultRacketsRepository(racketsLocalStorage: racketsCoreDataStorage)
    }
}
