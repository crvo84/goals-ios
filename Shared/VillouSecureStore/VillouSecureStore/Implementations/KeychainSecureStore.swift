//
//  KeychainSecureStore.swift
//  VillouSecureStore
//
//  Created by Carlos Villanueva Ousset on 16/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import Security

public struct KeychainSecureStore: SecureStore {

    public init() {}

    public func save<T: Codable>(_ value: T, directory: String, key: String) throws {
        let dataToStore = try encode(value)

        var query = queryFor(directory: directory, key: key)

        let retrieveStatus = SecItemCopyMatching(query as CFDictionary, nil)
        switch retrieveStatus {
        case errSecSuccess:
            // value with key exists in directory, we update it
            let attributesToUpdate: [String: Any] = [String(kSecValueData): dataToStore]
            let updateStatus = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            guard updateStatus == errSecSuccess else {
                throw SecureStoreError.storing(nil)
            }
        case errSecItemNotFound:
            // value with key does not exists in directory, we create it
            query[String(kSecValueData)] = dataToStore

            let createStatus = SecItemAdd(query as CFDictionary, nil)
            guard createStatus == errSecSuccess else {
                throw SecureStoreError.storing(nil)
            }
        default:
            throw SecureStoreError.retrieving(nil)
        }
    }

    public func retrieve<T: Codable>(_ type: T.Type, directory: String, key: String) throws -> T? {
        var query = queryFor(directory: directory, key: key)
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue

        var resultAttrs: AnyObject?
        let retrieveStatus = withUnsafeMutablePointer(to: &resultAttrs) { resultAttrsPointer in
            SecItemCopyMatching(query as CFDictionary, resultAttrsPointer)
        }

        switch retrieveStatus {
        case errSecSuccess:
            // value with key found in directory
            guard
                let validResultAttrs = resultAttrs as? [String: Any],
                let data = validResultAttrs[String(kSecValueData)] as? Data else {
                    throw SecureStoreError.retrieving(nil)
            }

            return try decode(T.self, from: data)

        case errSecItemNotFound:
            // value with key not found in directory
            return nil
        default:
            throw SecureStoreError.retrieving(nil)
        }
    }

    public func delete(directory: String, key: String) throws {
        let query = queryFor(directory: directory, key: key)
        let deleteStatus = SecItemDelete(query as CFDictionary)
        switch deleteStatus {
        case errSecSuccess, errSecItemNotFound:
            // either it was successfully deleted or there wasn't
            // any value with that key in that directory
            break
        default:
            throw SecureStoreError.deleting(nil)
        }
    }

    public func deleteAll(directory: String) throws {
        let query = queryFor(directory: directory, key: nil)
        let deleteAllStatus = SecItemDelete(query as CFDictionary)
        switch deleteAllStatus {
        case errSecSuccess, errSecItemNotFound:
            // either all values in the given directory were deleted or
            // there were not any values in it.
            break
        default:
            throw SecureStoreError.deleting(nil)
        }
    }

    public func deleteAllSecureStore() throws {
        let query = queryFor(directory: nil, key: nil)
        let deleteAllSecureStoreStatus = SecItemDelete(query as CFDictionary)
        switch deleteAllSecureStoreStatus {
        case errSecSuccess, errSecItemNotFound:
            // either all values in all directories (accessible to this app)
            // were deleted, or there were not any values.
            break
        default:
            throw SecureStoreError.deleting(nil)
        }
    }

    private func queryFor(directory: String?, key: String?) -> [String: Any] {
        var query: [String: Any] = [String(kSecClass): kSecClassGenericPassword]
        if let directory = directory {
            query[String(kSecAttrService)] = directory
        }
        if let key = key {
            query[String(kSecAttrAccount)] = key
        }

        return query
    }
}

private extension KeychainSecureStore {

    func encode<T: Encodable>(_ value: T) throws -> Data {
        do {
            return try JSONEncoder().encode(value)
        } catch {
            throw SecureStoreError.encoding(error)
        }
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw SecureStoreError.decoding(error)
        }
    }
}
