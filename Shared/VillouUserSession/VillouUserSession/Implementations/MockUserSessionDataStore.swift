//
//  MockUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public class MockUserSessionDataStore<UserSessionType: UserSession>: UserSessionDataStore {

    private var mockUserSession: UserSessionType?

    init(mockUserSession: UserSessionType?) {
        self.mockUserSession = mockUserSession
    }

    // MARK: Mock

    func setMock(userSession: UserSessionType?) {
        self.mockUserSession = userSession
    }

    // MARK: UserSession

    public func readUserSession<U>() -> Single<U?> where U : UserSession {
        <#code#>
    }

    public func save<U>(userSession: U) -> Single<U> where U : UserSession {
        <#code#>
    }

    public func delete<U>(userSession: U) -> Single<U> where U : UserSession {
        <#code#>
    }

}
