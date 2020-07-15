//
//  GoalsUserSessionRemoteService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import VillouNetworking
import VillouUserSession

struct GoalsUserSessionRemoteService: UserSessionRemoteService {

    let manager: NetworkingManager

    func signUp<T: SignUpDTO, U: UserSession>(dto: T) -> Single<U> {
        let req = UserSessionApi.signUp(body: dto.jsonData())
        return manager.execute(request: req, decodeType: U.self)
    }

    func signIn<T: SignInDTO, U: UserSession>(dto: T) -> Single<U> {
        let req = UserSessionApi.signIn(body: dto.jsonData())
        return manager.execute(request: req, decodeType: U.self)
    }
}
