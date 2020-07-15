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
    associatedtype SignInDTOType: Codable
    associatedtype SignUpDTOType: Codable
    associatedtype UserSessionType: Codable

    func signIn(dto: SignInDTOType) -> Single<UserSessionType>
    func signUp(dto: SignUpDTOType) -> Single<UserSessionType>
}
