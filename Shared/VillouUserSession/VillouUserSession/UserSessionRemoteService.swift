//
//  UserSessionRemoteService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public protocol UserSessionRemoteService {
    func signUp<T: SignUpDTO, U: UserSession>(dto: T) -> Single<U>
    func signIn<T: SignInDTO, U: UserSession>(dto: T) -> Single<U>
}
