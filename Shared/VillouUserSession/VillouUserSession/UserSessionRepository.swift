//
//  UserSessionRepository.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public protocol UserSessionRepository {
    var dataStore: UserSessionDataStore { get }
    var remoteService: UserSessionRemoteService { get }

    func readUserSession<U: UserSession>() -> Single<U?>
    func signUp<T: SignUpDTO, U: UserSession>(dto: T) -> Single<U>
    func signIn<T: SignInDTO, U: UserSession>(dto: T) -> Single<U>
    func signOut<U: UserSession>(userSession: U) -> Single<U>
}

public extension UserSessionRepository {

    func readUserSession<U: UserSession>() -> Single<U?> {
        dataStore.readUserSession()
    }

    func signUp<T: SignUpDTO, U: UserSession>(dto: T) -> Single<U> {
        remoteService.signUp(dto: dto)
            .flatMap(dataStore.save)
    }

    func signIn<T: SignInDTO, U: UserSession>(dto: T) -> Single<U> {
        remoteService.signIn(dto: dto)
            .flatMap(dataStore.save)
    }

    func signOut<U: UserSession>(userSession: U) -> Single<U> {
        dataStore.delete(userSession: userSession)
    }
}
