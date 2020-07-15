//
//  GoalsUserSessionRepository.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import VillouUserSession

class GoalsUserSessionRepository<DataStore: UserSessionDataStore, Service: UserSessionRemoteService>: UserSessionRepository {
    typealias UserSessionType = GoalsUserSession

    let dataStore: DataStore
    let service: Service

    init(dataStore: DataStore, service: Service) {
        self.dataStore = dataStore
        self.service = service
    }

    func readUserSession() -> Single<GoalsUserSession?> {
        return dataStore.readUserSession()
    }

    func signUp(dto: SignUpDTO) -> Single<GoalsUserSession> {
        <#code#>
    }

    func signIn(dto: SignInDTO) -> Single<GoalsUserSession> {
        <#code#>
    }

    func signOut(userSession: GoalsUserSession) -> Single<GoalsUserSession> {
        <#code#>
    }


//    func readUserSession() -> Single<UserSession?> {
//        return dataStore.readUserSession()
//    }
//
//    func signUp(dto: SignUpDTO) -> Single<UserSession> {
//        return service.signUp(dto: dto)
//            .flatMap(dataStore.save(userSession:))
//    }
//
//    func signIn(dto: SignInDTO) -> Single<UserSession> {
//        return service.signIn(dto: dto)
//            .flatMap(dataStore.save(userSession:))
//    }
//
//    func signOut(userSession: UserSession) -> Single<UserSession> {
//        return dataStore.delete(userSession: userSession)
//    }
}
