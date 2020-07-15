//
//  UserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserSessionDataStore {
    func readUserSession<UserSessionType: Codable>() -> Single<UserSessionType?>
    func save<UserSessionType: Codable>(userSession: UserSessionType) -> Single<UserSessionType>
    func delete<UserSessionType: Codable>(userSession: UserSessionType) -> Single<UserSessionType>
}
