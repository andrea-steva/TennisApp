//
//  UsersStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol UsersLocalStorage {

    /// Fetch users from local storage
    /// - Parameter completion: A completion handler. Returns an array of `UserResponseDTO.UserDTO` or an `Error`
    func fetch(completion: @escaping (Result<[User], CoreDataStorageError>) -> Void)

    /// Save users on local storage
    /// - Parameters:
    ///   - users: The array of users to save
    ///   - completion: The completion handler for the operation
    func save(users: [User], completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete user from local storage
    /// - Parameters:
    ///   - user: The user to delete
    ///   - completion: The completion handler for the operation
    func delete(user: User, completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete all the users from the local storage
    /// - Parameter completion: The completion handler for the operation
    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?)
}
