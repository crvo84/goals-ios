//
//  UserSessionRemoteService.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserSessionRemoteService {
    func signUp<SignUpDTOType: Codable, UserSessionType: Codable>(dto: SignUpDTOType) -> Single<UserSessionType>
    func signIn<SignInDTOType: Codable, UserSessionType: Codable>(dto: SignInDTOType) -> Single<UserSessionType>
}
