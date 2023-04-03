//
//  RacketsStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol RacketsLocalStorage {

    /// Fetch rackets from local storage
    /// - Parameter completion: A completion handler. Returns an array of `Racket` or an `Error`
    func fetch(completion: @escaping (Result<[Racket], CoreDataStorageError>) -> Void)

    /// Save rackets on local storage
    /// - Parameters:
    ///   - rackets: The array of rackets to save
    ///   - completion: The completion handler for the operation
    func save(rackets: [Racket], completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete racket from local storage
    /// - Parameters:
    ///   - racket: The racket to delete
    ///   - completion: The completion handler for the operation
    func delete(racket: Racket, completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete all the rackets from the local storage
    /// - Parameter completion: The completion handler for the operation
    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?)
}
