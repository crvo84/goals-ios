//
//  MockUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

public class MockUserSessionDataStore<MockUserSession>: UserSessionDataStore {

    private var userSession: MockUserSession?

    init(userSession: MockUserSession?) {
        self.userSession = userSession
    }

    // MARK: Mock

    func setMock(userSession: MockUserSession) {
        self.userSession = userSession
    }

    // MARK: UserSession

    func readUserSession() -> Single<MockUserSession?> {
        return .just(userSession)
    }

    func save(userSession: MockUserSession) -> Single<MockUserSession> {
        self.userSession = userSession

        return .just(userSession)
    }

    func delete(userSession: MockUserSession) -> Single<MockUserSession> {
        self.userSession = nil

        return .just(userSession)
    }
}
