//
//  UserSessionRemoteService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 17/07/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

protocol UserSessionRemoteService {
    func signUp(dto: SignUpDTO) -> Single<UserSession>
    func signIn(dto: SignInDTO) -> Single<UserSession>
}
