//
//  ProfileDIContainer.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 06/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

final class ProfileDIContainer {
    
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
