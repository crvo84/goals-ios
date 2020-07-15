//
//  GoalsUserSessionRemoteService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift
import VillouNetworking

struct GoalsUserSessionRemoteService: UserSessionRemoteService {

    let manager: NetworkingManager

    func signIn(dto: GoalsSignInDTO) -> Single<UserSession> {
        let req = UserSessionApi.signIn(body: dto.toData())
        return manager.execute(request: req, decodeType: UserSession.self)
    }

    func signUp(dto: GoalsSignUpDTO) -> Single<UserSession> {
        let req = UserSessionApi.signUp(body: dto.toData())
        return manager.execute(request: req, decodeType: UserSession.self)
    }

}
