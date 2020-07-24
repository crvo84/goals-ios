//
//  GoalsUserSessionRemoteService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift
import VillouNetworking

struct GoalsUserSessionRemoteService: UserSessionRemoteService {

    let manager: NetworkingManager

    func signUp(dto: SignUpDTO) -> Single<UserSession> {
        let req = UserSessionApi.signUp(body: dto.jsonData())
        return manager.execute(request: req, decodeType: SignUpResponseContent.self)
            .map { $0.userSession }
    }

    func signIn(dto: SignInDTO) -> Single<UserSession> {
        let req = UserSessionApi.signIn(body: dto.jsonData())
        return manager.execute(request: req, decodeType: SignInResponseContent.self)
            .map { $0.userSession }
    }
}
