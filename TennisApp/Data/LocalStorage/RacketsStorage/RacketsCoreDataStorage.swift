//
//  RacketsCoreDataStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import CoreData
import Foundation

final class RacketsCoreDataStorage: RacketsLocalStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: UsersLocalStorage

    func fetch(completion: @escaping (Result<[Racket], CoreDataStorageError>) -> Void) {
        do {
            let request: NSFetchRequest = RacketEntity.fetchRequest()
            let result = try coreDataStorage.managedContext.fetch(request).compactMap {
                $0.toDomain()
            }
            completion(.success(result))
        } catch {
            completion(.failure(CoreDataStorageError.readError(error)))
        }
    }

    func save(rackets: [Racket], completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            for racket in rackets {
                _ = RacketEntity(racket: racket, insertInto: coreDataStorage.managedContext)
            }
            try coreDataStorage.saveContext()
            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.saveError(error)))
        }
    }

    func delete(racket: Racket, completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            let request: NSFetchRequest = RacketEntity.fetchRequest()
            request.predicate = NSPredicate(format: "identifier == %@", racket.identifier)

            let result = try coreDataStorage.managedContext.fetch(request)
            result.forEach { racket in
                coreDataStorage.managedContext.delete(racket)
            }
            try coreDataStorage.saveContext()

            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.readError(error)))
        }
    }

    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            let request: NSFetchRequest = RacketEntity.fetchRequest()
            let result = try coreDataStorage.managedContext.fetch(request)
            result.forEach { coreDataStorage.managedContext.delete($0) }
            try coreDataStorage.saveContext()
            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.readError(error)))
        }
    }
}
