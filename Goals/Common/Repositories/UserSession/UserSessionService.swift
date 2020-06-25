//
//  UserSessionService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

protocol UserSessionService {

    func signIn(dto: SignInDTO) -> Single<UserSession>
    func signUp(dto: SignUpDTO) -> Single<UserSession>
}
