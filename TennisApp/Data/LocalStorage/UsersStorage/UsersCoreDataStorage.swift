//
//  UsersCoreDataStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import CoreData
import Foundation

final class UsersCoreDataStorage: UsersLocalStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage()) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: UsersLocalStorage

    func fetch(completion: @escaping (Result<[User], CoreDataStorageError>) -> Void) {
        do {
            let request: NSFetchRequest = UserEntity.fetchRequest()
            let result = try coreDataStorage.managedContext.fetch(request).compactMap {
                $0.toDomain()
            }
            completion(.success(result))
        } catch {
            completion(.failure(CoreDataStorageError.readError(error)))
        }
    }

    func save(users: [User], completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            for user in users {
                _ = UserEntity(user: user, insertInto: coreDataStorage.managedContext)
            }
            try coreDataStorage.saveContext()
            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.saveError(error)))
        }
    }

    func delete(user: User, completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            let request: NSFetchRequest = UserEntity.fetchRequest()
            request.predicate = NSPredicate(format: "identifier == %@", user.identifier)
            
            let result = try coreDataStorage.managedContext.fetch(request)
            result.forEach { user in
                coreDataStorage.managedContext.delete(user)
            }
            try coreDataStorage.saveContext()

            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.readError(error)))
        }
    }

    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?) {
        do {
            let request: NSFetchRequest = UserEntity.fetchRequest()
            let result = try coreDataStorage.managedContext.fetch(request)
            result.forEach { coreDataStorage.managedContext.delete($0) }
            try coreDataStorage.saveContext()
            completion?(.success(true))
        } catch {
            completion?(.failure(CoreDataStorageError.readError(error)))
        }
    }
}
