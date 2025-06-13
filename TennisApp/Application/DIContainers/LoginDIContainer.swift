//
//  LoginDIContainer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class LoginDIContainer {

    // MARK: Local Storage

    private lazy var usersCoreDataStorage = UsersCoreDataStorage()

    // MARK: UseCases

    func makeUserPrimaryFetchUseCase() -> UserPrimaryFetchUseCase {
        DefaultUserPrimaryFetchUseCase(usersRepository: makeUsersRepository())
    }

    // MARK: Repositories

    private func makeUsersRepository() -> UsersRepository {
        DefaultUsersRepository(usersLocalStorage: usersCoreDataStorage)
    }
}
