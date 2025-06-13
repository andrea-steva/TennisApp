//
//  UserSaveUserCase.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// Save a user on the local storage
protocol UserSaveUserCase {
    func execute(user: User,
                 completion: @escaping (Result<Bool, Error>) -> Void)
}

final class DefaultUserSaveUserCase: UserSaveUserCase {

    // MARK: Properties

    private let usersRepository: UsersRepository

    // MARK: Init

    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }

    // MARK: Use case execution

    func execute(user: User,
                 completion: @escaping (Result<Bool, Error>) -> Void) {
        usersRepository.save(user: user, completion: completion)
    }
}
