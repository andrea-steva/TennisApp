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

    func create(racket: Racket, completion: @escaping (Result<Bool, Error>) -> Void) {
        racketsLocalStorage.save(rackets: [racket]) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func update(racket: Racket, completion: @escaping (Result<Bool, Error>) -> Void) {
        racketsLocalStorage.save(rackets: [racket]) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteRackets(completion: ((Result<Bool, Error>) -> Void)?) {
        racketsLocalStorage.deleteAll(completion: completion)
    }

    //TODO Create method to delete single racket
    func deleteRacket(racket: Racket, completion: ((Result<Bool, Error>) -> Void)?) {
        racketsLocalStorage.deleteAll(completion: completion)
    }
}
