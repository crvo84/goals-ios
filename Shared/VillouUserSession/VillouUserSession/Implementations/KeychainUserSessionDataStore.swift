//
//  KeychainUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import VillouSecureStore

public final class KeychainUserSessionDataStore<U: UserSession>: UserSessionDataStore {

    public typealias UserSessionType = U

    private let secureStore: SecureStore
    private let directory = "Villou.UserSession.Directory"
    private let key = "Villou.UserSession.Key"

    public init() {
        self.secureStore = KeychainSecureStore()
    }

    // internal init for unit testing
    internal init(secureStore: SecureStore) {
        self.secureStore = secureStore
    }

    public func readUserSession() -> Single<U?> {
        do {
            let session = try secureStore.retrieve(U.self, directory: directory, key: key)
            return .just(session)
        } catch {
            return .error(error)
        }
    }

    public func save(userSession: U) -> Single<U> {
        do {
            try secureStore.save(userSession, directory: directory, key: key)
            return .just(userSession)
        } catch {
            return .error(error)
        }
    }

    public func delete(userSession: U) -> Single<U> {
        do {
            try secureStore.delete(directory: directory, key: key)
            return .just(userSession)
        } catch {
            return .error(error)
        }
    }

    public func deleteAllSessions() -> Completable {
        do {
            try secureStore.deleteAll(directory: directory)
            return .empty()
        } catch {
            return .error(error)
        }
    }
}
