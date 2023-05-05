//
//  SignUpDIContainer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 02/05/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class SignUpDIContainer {

    // MARK: Local Storage

    private lazy var usersCoreDataStorage = UsersCoreDataStorage()

    // MARK: UseCases

    func makeUserSaveUse() -> UserSaveUserCase {
        DefaultUserSaveUserCase(usersRepository: makeUsersRepository())
    }

    // MARK: Repositories

    private func makeUsersRepository() -> UsersRepository {
        DefaultUsersRepository(usersLocalStorage: usersCoreDataStorage)
    }
}
