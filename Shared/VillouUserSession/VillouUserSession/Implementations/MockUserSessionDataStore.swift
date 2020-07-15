//
//  MockUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public class MockUserSessionDataStore<T: UserSession>: UserSessionDataStore {
    public typealias UserSessionType = T

    private var mockUserSession: T?

    init(mockUserSession: T?) {
        self.mockUserSession = mockUserSession
    }

    // MARK: Mock

    func setMock(userSession: T?) {
        self.mockUserSession = userSession
    }

    // MARK: UserSession

    public func readUserSession() -> Single<T?> {
        .just(mockUserSession)
    }

    public func save(userSession: T) -> Single<T> {
        self.mockUserSession = userSession
        return .just(userSession)
    }

    public func delete(userSession: T) -> Single<T> {
        self.mockUserSession = nil
        return .just(userSession)
    }
}
