//
//  DefaultStringsRepository.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class DefaultStringsRepository: StringsRepository {

    // MARK: Properties

    private let stringsLocalStorage: StringsLocalStorage

    // MARK: Initialization

    init(stringsLocalStorage: StringsLocalStorage = StringsCoreDataStorage()) {
        self.stringsLocalStorage = stringsLocalStorage
    }

    // MARK: Methods

    func fetch(forRacket racket: Racket, completion: @escaping (Result<[Strings], Error>) -> Void) {
        stringsLocalStorage.fetch(forRacket: racket) { result in
            switch result {
            case .success(let strings):
                completion(.success(strings))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func save(string: Strings, forRacket racket: Racket, completion: @escaping (Result<Bool, Error>) -> Void) {
        stringsLocalStorage.save(string: string, forRacket: racket) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func delete(string: Strings, completion: ((Result<Bool, Error>) -> Void)?) {
        stringsLocalStorage.delete(string: string, completion: completion)
    }

    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?) {
        stringsLocalStorage.deleteAll(completion: completion)
    }
}
