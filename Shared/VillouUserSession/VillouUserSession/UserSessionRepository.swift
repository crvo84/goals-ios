//
//  UserSessionRepository.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public protocol UserSessionRepository {
    associatedtype SignInDTOType: Codable
    associatedtype SignUpDTOType: Codable
    associatedtype UserSessionType: Codable

    func readUserSession() -> Single<UserSessionType?>
    func signUp(dto: SignUpDTOType) -> Single<UserSessionType>
    func signIn(dto: SignInDTOType) -> Single<UserSessionType>
    func signOut(userSession: UserSessionType) -> Single<UserSessionType>
}
