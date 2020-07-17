//
//  MockUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public final class MockUserSessionDataStore<U: UserSession>: UserSessionDataStore {

    public typealias UserSessionType = U

    private var mockUserSession: U?

    public init(mockUserSession: UserSessionType?) {
        self.mockUserSession = mockUserSession
    }

    // MARK: Mock

    public func setMock(userSession: UserSessionType?) {
        self.mockUserSession = userSession
    }

    // MARK: UserSession

    public func readUserSession() -> Single<U?> {
        .just(mockUserSession)
    }

    public func save(userSession: U) -> Single<U> {
        self.mockUserSession = userSession
        return .just(userSession)
    }

    public func delete(userSession: U) -> Single<U> {
        self.mockUserSession = nil
        return .just(userSession)
    }

    public func deleteAllSessions() -> Completable {
        self.mockUserSession = nil
        return .empty()
    }
}
