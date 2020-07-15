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

    func readUserSession<UserSessionType: Codable>() -> Single<UserSessionType?>
    func signUp<SignUpDTOType: Codable, UserSessionType: Codable>(dto: SignUpDTOType) -> Single<UserSessionType>
    func signIn<SignInDTOType: Codable, UserSessionType: Codable>(dto: SignInDTOType) -> Single<UserSessionType>
    func signOut<UserSessionType: Codable>(userSession: UserSessionType) -> Single<UserSessionType>
}
