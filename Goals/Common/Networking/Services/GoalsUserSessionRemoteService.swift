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

    func signUp(dto: GoalsSignUpDTO) -> Single<GoalsUserSession> {
        let req = UserSessionApi.signUp(body: dto.jsonData())
        return manager.execute(request: req, decodeType: GoalsUserSession.self)
    }

    func signIn(dto: GoalsSignInDTO) -> Single<GoalsUserSession> {
        let req = UserSessionApi.signIn(body: dto.jsonData())
        return manager.execute(request: req, decodeType: GoalsUserSession.self)
    }
}
