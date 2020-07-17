//
//  GoalsUserSessionRepository.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

class GoalsUserSessionRepository {
    let dataStore: UserSessionDataStore
    let remoteService: UserSessionRemoteService

    init(dataStore: UserSessionDataStore, remoteService: UserSessionRemoteService) {
        self.dataStore = dataStore
        self.remoteService = remoteService
    }
}

extension GoalsUserSessionRepository: UserSessionRepository {
    func readUserSession() -> Single<UserSession?> {
        dataStore.readUserSession()
    }

    func signUp(dto: SignUpDTO) -> Single<UserSession> {
        remoteService.signUp(dto: dto)
            .flatMap(dataStore.save)
    }

    func signIn(dto: SignInDTO) -> Single<UserSession> {
        remoteService.signIn(dto: dto)
            .flatMap(dataStore.save)
    }

    func signOut(userSession: UserSession) -> Completable {
        dataStore.delete(userSession: userSession)
    }
}
