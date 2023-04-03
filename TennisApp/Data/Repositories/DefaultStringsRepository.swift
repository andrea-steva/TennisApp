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

    func fetch(completion: @escaping (Result<[Strings], Error>) -> Void) {
        stringsLocalStorage.fetch { result in
            switch result {
            case .success(let strings):
                completion(.success(strings))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func create(strings: Strings, completion: @escaping (Result<Bool, Error>) -> Void) {
        stringsLocalStorage.save(strings: [strings]) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func update(strings: Strings, completion: @escaping (Result<Bool, Error>) -> Void) {
        stringsLocalStorage.save(strings: [strings]) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteStrings(completion: ((Result<Bool, Error>) -> Void)?) {
        stringsLocalStorage.deleteAll(completion: completion)
    }
}
