//
//  GoalsUserSessionRepository.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

class GoalsUserSessionRepository: UserSessionRepository {

    let dataStore: UserSessionDataStore
    let service: UserSessionService

    init(dataStore: UserSessionDataStore, service: UserSessionService) {
        self.dataStore = dataStore
        self.service = service
    }

    func readUserSession() -> Single<UserSession?> {
        return dataStore.readUserSession()
    }

    func signUp(info: NewUserInfo) -> Single<UserSession> {
        return service.signUp(info: info)
            .flatMap(dataStore.save(userSession:))
    }

    func signIn(email: String, password: String) -> Single<UserSession> {
        return service.signIn(email: email, password: password)
            .flatMap(dataStore.save(userSession:))
    }

    func signOut(userSession: UserSession) -> Single<UserSession> {
        return dataStore.delete(userSession: userSession)
    }
}
