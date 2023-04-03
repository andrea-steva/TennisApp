//
//  DefaultUsersRepository.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class DefaultUsersRepository: UsersRepository {

    // MARK: Properties

    private let usersLocalStorage: UsersLocalStorage

    // MARK: Initialization

    init(usersLocalStorage: UsersLocalStorage) {
        self.usersLocalStorage = usersLocalStorage
    }

    // MARK: Methods

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        usersLocalStorage.fetchUsers { users in
            let users = users.map { $0.toDomain() }
            completion(.success(users))
        }
//        usersLocalStorage.fetch { result in
//            switch result {
//            case .success(let users):
//                let users = users.map { $0.toDomain() }
//                completion(.success(users))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }

    func deleteUsers(completion: ((Result<Bool, Error>) -> Void)?) {
        // usersLocalStorage.deleteAll(completion: completion)
    }
}
