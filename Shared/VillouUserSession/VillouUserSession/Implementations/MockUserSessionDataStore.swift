//
//  MockUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

public class MockUserSessionDataStore<T: UserSession>: UserSessionDataStore {

    private var mockUserSession: T?

    init(mockUserSession: T?) {
        self.mockUserSession = mockUserSession
    }

    // MARK: Mock

    func setMock(userSession: T) {
        self.mockUserSession = userSession
    }

    // MARK: UserSession
    

//    func readUserSession() -> Single<MockUserSession?> {
//        return .just(userSession)
//    }
//
//    func save(userSession: MockUserSession) -> Single<MockUserSession> {
//        self.userSession = userSession
//
//        return .just(userSession)
//    }
//
//    func delete(userSession: MockUserSession) -> Single<MockUserSession> {
//        self.userSession = nil
//
//        return .just(userSession)
//    }
}
