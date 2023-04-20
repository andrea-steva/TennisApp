//
//  StringsStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 31/03/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol StringsLocalStorage {

    /// Fetch strings for a Racket from local storage
    /// - Parameters:
    ///   - racket: The racket
    ///   - completion: A completion handler. Returns an array of `Strings` or an `Error`
    func fetch(forRacket racket: Racket, completion: @escaping (Result<[Strings], CoreDataStorageError>) -> Void)

    /// Save string on local storage
    /// - Parameters:
    ///   - string: The string to save
    ///   - racket: The racket
    ///   - completion: The completion handler for the operation
    func save(string: Strings, forRacket racket: Racket, completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete strings from local storage
    /// - Parameters:
    ///   - strings: The string to delete
    ///   - completion: The completion handler for the operation
    func delete(string: Strings, completion: ((Result<Bool, Error>) -> Void)?)

    /// Delete all the strings from the local storage
    /// - Parameter completion: The completion handler for the operation
    func deleteAll(completion: ((Result<Bool, Error>) -> Void)?)
}
