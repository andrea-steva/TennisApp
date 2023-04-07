//
//  StringsRepository.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// Represent the `strings` repository. Within this object you can fetch strings
protocol StringsRepository {

    /// Fetch `Strings` from local storage
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Strings` or a `Error`
    func fetch(completion: @escaping (Result<[Strings], Error>) -> Void)

    /// Create a single `Strings`
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Strings` or a `Error`
    func create(string: Strings, completion: @escaping (Result<Bool, Error>) -> Void)

    /// Update a single `Strings`
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Strings` or a `Error`
    func update(string: Strings, completion: @escaping (Result<Bool, Error>) -> Void)

    /// Delete a single `Strings`
    /// - Parameters:
    ///   - string: the `Strings` to delete
    ///   - completion: The completion handler for the operation
    func delete(string: Strings, completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete all the strings from the local storage
    /// - Parameter completion: The completion handler for the operation
    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?)
}
