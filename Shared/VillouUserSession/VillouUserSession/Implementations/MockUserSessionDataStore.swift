//
//  MockUserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

public class MockUserSessionDataStore: UserSessionDataStore {

    private let mockSession: UserSession

    init(hasSession: Bool) {
        self.hasSession = hasSession
    }

    func readUserSession() -> Single<UserSession?> {
        var session: UserSession?
        if hasSession {
            UserProfile
            let mockProfile = UserProfile(fullName: "Carlos Villanueva", nickName: "crvo84", email: "crvo84@gmail.com", avatar: nil)
            let mockRemoteSession = RemoteSession(token: "123456789")
            session = UserSession(profile: mockProfile, remoteSession: mockRemoteSession)
        }

        return .just(session)
    }

    func save(userSession: UserSession) -> Single<UserSession> {
        return .just(userSession)
    }

    func delete(userSession: UserSession) -> Single<UserSession> {
        return .just(userSession)
    }

}
