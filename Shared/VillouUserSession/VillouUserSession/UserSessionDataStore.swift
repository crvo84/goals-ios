//
//  UserSessionDataStore.swift
//  Goals
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import RxSwift

public protocol UserSessionDataStore {
    associatedtype UserSessionType: UserSession

    func readUserSession() -> Single<UserSessionType?>
    func save(userSession: UserSessionType) -> Single<UserSessionType>
    func delete(userSession: UserSessionType) -> Single<UserSessionType>
    func deleteAllSessions() -> Completable
}
