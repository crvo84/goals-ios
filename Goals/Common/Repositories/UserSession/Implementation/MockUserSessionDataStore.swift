//
//  MockUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

class MockUserSessionDataStore {

    private var userSession: UserSession?

    init(userSession: UserSession?) {
        self.userSession = userSession
    }
}

extension MockUserSessionDataStore: UserSessionDataStore {
    func readUserSession() -> Single<UserSession?> {
        .just(userSession)
    }

    func save(userSession: UserSession) -> Single<UserSession> {
        self.userSession = userSession
        return .just(userSession)
    }

    func delete(userSession: UserSession) -> Completable {
        self.userSession = nil
        return .empty()
    }

    func deleteAllSessions() -> Completable {
        self.userSession = nil
        return .empty()
    }
}
