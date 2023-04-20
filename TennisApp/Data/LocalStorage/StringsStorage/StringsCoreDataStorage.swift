//
//  StringsCoreDataStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import CoreData
import Foundation

final class StringsCoreDataStorage: StringsLocalStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: Strings Local Storage

    func fetch(forRacket racket: Racket, completion: @escaping (Result<[Strings], CoreDataStorageError>) -> Void) {
        do {
            let racketRequest: NSFetchRequest = RacketEntity.fetchRequest()
            racketRequest.predicate = NSPredicate(format: "identifier == %@", racket.identifier)

            let racketResult = try coreDataStorage.managedContext.fetch(racketRequest)
            guard let racketEntity = racketResult.first else {
                completion(.success([]))
                return
            }

            let strings = racketEntity.strings?.compactMap { ($0 as? StringsEntity)?.toDomain() } ?? []
            completion(.success(strings))
        } catch {
            completion(.failure(CoreDataStorageError.readError(error)))
        }
    }

    func save(string: Strings, forRacket racket: Racket, completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            let request: NSFetchRequest = RacketEntity.fetchRequest()
            request.predicate = NSPredicate(format: "identifier == %@", racket.identifier)

            let result = try coreDataStorage.managedContext.fetch(request)
            guard let racketEntity = result.first else {
                completion?(.failure(CoreDataStorageError.notFound))
                return
            }

            let stringEntity = StringsEntity(strings: string, insertInto: coreDataStorage.managedContext)
            racketEntity.addToStrings(stringEntity)
            try coreDataStorage.saveContext()

            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.saveError(error)))
        }
    }

    func delete(string: Strings, completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            let request: NSFetchRequest = StringsEntity.fetchRequest()
            request.predicate = NSPredicate(format: "identifier == %@", string.identifier)

            let result = try coreDataStorage.managedContext.fetch(request)
            result.forEach { singleStrings in
                coreDataStorage.managedContext.delete(singleStrings)
            }
            try coreDataStorage.saveContext()

            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.readError(error)))
        }
    }

    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            let request: NSFetchRequest = StringsEntity.fetchRequest()
            let result = try coreDataStorage.managedContext.fetch(request)
            result.forEach { coreDataStorage.managedContext.delete($0) }
            try coreDataStorage.saveContext()
            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.readError(error)))
        }
    }
}
