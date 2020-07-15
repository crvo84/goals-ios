//
//  UserSessionRemoteService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public protocol UserSessionRemoteService {
    associatedtype SignUpDTOType: SignUpDTO
    associatedtype SignInDTOType: SignInDTO
    associatedtype UserSessionType: UserSession

    func signUp(dto: SignUpDTOType) -> Single<UserSessionType>
    func signIn(dto: SignInDTOType) -> Single<UserSessionType>
}
