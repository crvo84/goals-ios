//
//  UserSessionRepository.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public protocol UserSessionRepository {
    associatedtype SignUpDTOType: SignUpDTO
    associatedtype SignInDTOType: SignInDTO
    associatedtype UserSessionType: UserSession
    associatedtype DataStoreType: UserSessionDataStore
    associatedtype RemoteServiceType: UserSessionRemoteService

    var dataStore: DataStoreType { get }
    var remoteService: RemoteServiceType { get }

    func readUserSession() -> Single<UserSessionType?>
    func signUp(dto: SignUpDTOType) -> Single<UserSessionType>
    func signIn(dto: SignInDTOType) -> Single<UserSessionType>
    func signOut(userSession: UserSessionType) -> Single<UserSessionType>
}
