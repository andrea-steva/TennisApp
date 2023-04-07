//
//  UserDefaultsStorage.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Foundation

protocol UserDefaultsStorage {

    /// The user defaults instance
    var userDefaults: UserDefaults { get }

    /// Returns an object saved on user defaults
    ///
    /// - Parameter key: The key for the object to save
    /// - Returns: The object to save or nil if not present
    func get(_ key: String) -> Any?

    /// Set an object on user defaults
    ///
    /// - Parameters:
    ///   - key: The object's key
    ///   - value: The object to save
    func set(_ key: String, value: Any?)

    /// Reset all the objects on UserDefaults.
    /// - Note: Use only for test. Do not use this in production
    /// - Important: Erases all keys for all clients, libraries, etc. You probably don't want to call this. Remove only your app keys using `set` method.
    func resetAll()
}

extension UserDefaultsStorage {

    // MARK: - Get set reset from user defaults

    func get(_ key: String) -> Any? {
        userDefaults.value(forKey: key) as Any?
    }

    func set(_ key: String, value: Any?) {
        if value != nil {
            userDefaults.setValue(value, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }

    func resetAll() {
        userDefaults.dictionaryRepresentation().keys.forEach { userDefaults.removeObject(forKey: $0) }
    }

    // MARK: - Encode and decode a Codable

    func decodeObject<T: Decodable>(object: Data, type: T.Type) -> T? {
        try? JSONDecoder().decode(T.self, from: object)
    }

    func encodeObject<T: Encodable>(value: T) -> Data? {
        try? JSONEncoder().encode(value)
    }

    func decodeArrayObject<T: Decodable>(object: Data, type: T.Type) -> [T]? {
        try? JSONDecoder().decode([T].self, from: object)
    }

    func encodeArrayObject<T: Encodable>(value: [T]) -> Data? {
        try? JSONEncoder().encode(value)
    }
}
