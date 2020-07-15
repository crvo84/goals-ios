//
//  UserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public protocol UserSessionDataStore {
    func readUserSession<U: UserSession>() -> Single<U?>
    func save<U: UserSession>(userSession: U) -> Single<U>
    func delete<U: UserSession>(userSession: U) -> Single<U>
}
