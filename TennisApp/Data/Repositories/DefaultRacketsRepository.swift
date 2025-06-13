//
//  DefaultRacketsRepository.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class DefaultRacketsRepository: RacketsRepository {

    // MARK: Properties

    private let racketsLocalStorage: RacketsLocalStorage

    // MARK: Initialization

    init(racketsLocalStorage: RacketsLocalStorage = RacketsCoreDataStorage()) {
        self.racketsLocalStorage = racketsLocalStorage
    }

    // MARK: Methods

    func fetch(completion: @escaping (Result<[Racket], Error>) -> Void) {
        racketsLocalStorage.fetch { result in
            switch result {
            case .success(let rackets):
                completion(.success(rackets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func save(racket: Racket, completion: @escaping (Result<Bool, Error>) -> Void) {
        racketsLocalStorage.save(rackets: [racket]) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func delete(racket: Racket, completion: ((Result<Bool, Error>) -> Void)?) {
        racketsLocalStorage.delete(racket: racket, completion: completion)
    }

    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?) {
        racketsLocalStorage.deleteAll(completion: completion)
    }
}
