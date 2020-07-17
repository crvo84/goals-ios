//
//  SecureUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import VillouSecurity

class SecureUserSessionDataStore {
    let secureStore: SecureStore

    init(secureStore: SecureStore) {
        self.secureStore = secureStore
    }
}

extension SecureUserSessionDataStore: UserSessionDataStore {

    private var directory: String { "Goals.UserSession.Directory" }
    private var key: String { "Goals.UserSession.Key" }

    func readUserSession() -> Single<UserSession?> {
        do {
            let session = try secureStore.retrieve(UserSession.self, directory: directory, key: key)
            return .just(session)
        } catch {
            return .error(error)
        }
    }

    func save(userSession: UserSession) -> Single<UserSession> {
        do {
            try secureStore.save(userSession, directory: directory, key: key)
            return .just(userSession)
        } catch {
            return .error(error)
        }
    }

    func delete(userSession: UserSession) -> Completable {
        do {
            try secureStore.delete(directory: directory, key: key)
            return .empty()
        } catch {
            return .error(error)
        }
    }

    func deleteAllSessions() -> Completable {
        do {
            try secureStore.deleteAll(directory: directory)
            return .empty()
        } catch {
            return .error(error)
        }
    }

}
