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

    /// Fetch from local storage
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Strings` or a `Error`
    func fetch(completion: @escaping (Result<[Strings], Error>) -> Void)

    /// Create
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Strings` or a `Error`
    func create(strings: Strings, completion: @escaping (Result<Bool, Error>) -> Void)

    /// Update
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Strings` or a `Error`
    func update(strings: Strings, completion: @escaping (Result<Bool, Error>) -> Void)

    /// Delete all the strings from the local storage
    /// - Parameter completion: The completion handler for the operation
    func deleteStrings(completion: ((Result<Bool, Error>) -> Void)?)
}
