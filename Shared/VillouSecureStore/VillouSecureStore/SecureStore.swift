//
//  SecureStore.swift
//  VillouSecureStore
//
//  Created by Carlos Villanueva Ousset on 16/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public protocol SecureStore {

    /// Saves the given value in the given directory with the given key.
    func save<T: Codable>(_ value: T, directory: String, key: String) throws

    /// Retrieves the value from the given directory for the given key.
    /// Returns `nil` if no value was found.
    func retrieve<T: Codable>(_ type: T.Type, directory: String, key: String) throws -> T?

    /// Deletes the value in the given directory for the given key.
    /// If there is no value, no error should be thrown.
    func delete(directory: String, key: String) throws

    /// Deletes all values saved in the given directory.
    func deleteAll(directory: String) throws

    /// Deletes all values saved in the secure store.
    func deleteAllSecureStore() throws
}
