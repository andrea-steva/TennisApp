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

    init(coreDataStorage: CoreDataStorage = CoreDataStorage()) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: UsersLocalStorage

    func fetch(completion: @escaping (Result<[Strings], CoreDataStorageError>) -> Void) {
        do {
            let request: NSFetchRequest = StringsEntity.fetchRequest()
            let result = try coreDataStorage.managedContext.fetch(request).compactMap {
                $0.toDomain()
            }
            completion(.success(result))
        } catch {
            completion(.failure(CoreDataStorageError.readError(error)))
        }
    }

    func save(strings: [Strings], completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            for singleStrings in strings {
                _ = StringsEntity(strings: singleStrings, insertInto: coreDataStorage.managedContext)
            }
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
