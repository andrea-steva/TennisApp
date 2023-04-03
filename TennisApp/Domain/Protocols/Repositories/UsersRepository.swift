//
//  UsersRepository.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// Represent the `users` repository. Within this object you can fetch users from the differnt types storage
protocol UsersRepository {

    /// Fetch from local storage
    /// - Parameter completion: The completion handler for the operation. Returns an array of `User` or a `Error`
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
    
    /// Delete all the users from the local storage
    /// - Parameter completion: The completion handler for the operation
    func deleteUsers(completion: ((Result<Bool, Error>) -> Void)?)
}
