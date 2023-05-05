//
//  UserPrimaryFetchUseCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

enum UsersError: Error {
    case notFound
}

/// Fetch the primary `User` of the app
protocol UserPrimaryFetchUseCase {
    func execute(completion: @escaping (Result<User, UsersError>) -> Void)
}

final class DefaultUserPrimaryFetchUseCase: UserPrimaryFetchUseCase {

    // MARK: Properties

    private let usersRepository: UsersRepository

    // MARK: Init

    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }

    // MARK: Use case execution

    func execute(completion: @escaping (Result<User, UsersError>) -> Void) {
        usersRepository.fetch { result in
            switch result {
            case .success(let users):
                guard let primaryUser = users.first(where: { $0.isPrimary }) else {
                    completion(.failure(UsersError.notFound))
                    return
                }
                completion(.success(primaryUser))
            case .failure:
                completion(.failure(UsersError.notFound))
            }
        }
    }
}
