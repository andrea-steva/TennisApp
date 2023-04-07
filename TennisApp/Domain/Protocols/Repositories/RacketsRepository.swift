//
//  RacketsRepository.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 03/04/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

/// Represent the `rackets` repository. Within this object you can fetch rackets
protocol RacketsRepository {

    /// Fetch from local storage
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Racket` or a `Error`
    func fetch(completion: @escaping (Result<[Racket], Error>) -> Void)

    /// Create
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Racket` or a `Error`
    func create(racket: Racket, completion: @escaping (Result<Bool, Error>) -> Void)

    /// Update
    /// - Parameter completion: The completion handler for the operation. Returns an array of `Racket` or a `Error`
    func update(racket: Racket, completion: @escaping (Result<Bool, Error>) -> Void)

    /// Delete a single `Racket`
    /// - Parameters:
    ///   - racket: the `Racket` to delete
    ///   - completion: The completion handler for the operation
    func delete(racket: Racket, completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete all the rackets from the local storage
    /// - Parameter completion: The completion handler for the operation
    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?)
}
