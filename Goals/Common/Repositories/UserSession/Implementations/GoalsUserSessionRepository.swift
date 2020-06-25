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

    func signUp(dto: SignUpDTO) -> Single<UserSession> {
        return service.signUp(dto: dto)
            .flatMap(dataStore.save(userSession:))
    }

    func signIn(dto: SignInDTO) -> Single<UserSession> {
        return service.signIn(dto: dto)
            .flatMap(dataStore.save(userSession:))
    }

    func signOut(userSession: UserSession) -> Single<UserSession> {
        return dataStore.delete(userSession: userSession)
    }
}
